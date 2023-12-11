import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.dart';
import 'package:rzf_canvasing_sirwal/enum/product_price_type.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/extension.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_cart.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_qty_unit_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class TsxProductListController extends GetxController {
  TransactionType? transactionType;
  final searchController = TextEditingController();
  final refreshController = RefreshController(initialRefresh: false);
  final personController = TextEditingController();
  var startPage = 1;
  var lastPage = 1;
  var isLastPage = false.obs;
  var isLoading = false.obs;

  var customer = Rx<Customer?>(null);
  var total = 0.0.obs;
  var point = 0.obs;
  var totalProduct = 0.obs;
  var productOnCarts = <ProductOnCart>[].obs;
  var productList = <ProductOnCart>[].obs;
  Timer? debouncer;
  late Future<bool> Function(List<ProductOnCart>, Customer) onSave;

  TsxProductListController(this.transactionType);

  Future<List<Product>> _getDataProduct({String keyword = ''}) async {
    var data = await ProductData().fetchApiData(
      startPage: startPage,
      value: keyword,
    );
    lastPage = data['last_page'];
    isLastPage.value = startPage >= lastPage;
    startPage++;
    return data['data'];
  }

  refreshData({String keyword = ''}) async {
    startPage = 1;
    isLoading.value = true;
    var data = await _getDataProduct(keyword: keyword);
    await _setData(data, true);
    _setIntoBaseData();
    isLoading.value = false;
    refreshController.refreshCompleted();
  }

  loadData() async {
    var data = await _getDataProduct();
    await _setData(data, false);
    productList.refresh();
    refreshController.loadComplete();
  }

  _setData(List<Product> data, bool clearFirst) {
    if (clearFirst) productList.clear();
    for (var item in data) {
      productList.add(ProductOnCart.fromParent(item, transactionType!));
    }
  }

  onBtnScanClick() async {
    var data = await Get.toNamed(Routes.scannerView);
    if (data != null) {
      var barcode = data as Barcode;
      _onProductScanned(barcode);
    }
  }

  _onProductScanned(Barcode barcode) async {
    waitingDialog();
    var data = await ProductData().getSingleProduct(barcode.code!);
    Get.back();
    if (data != null) {
      await Future.delayed(const Duration(milliseconds: 100));
      var product = ProductOnCart.fromParent(data, transactionType!);
      showBottomBar(
        AppTsxQtyUnitDialog(
          product: product,
          onCart: 0,
          initialUnit: null,
          onDone: (qty, unit, point) {
            Get.back();
            onProductChanged(
              product
                ..onCart = qty
                ..unit = unit
                ..pointsEarned = point,
            );
            _setIntoBaseData();
          },
        ),
      );
    } else {
      showSnackbar("Product tidak ditemukan", const Color(0xFFFDBF44));
    }
  }

  onCartSave() async {
    if (customer.value != null && productOnCarts.isNotEmpty) {
      var isClear = await onSave(productOnCarts, customer.value!);
      if (isClear) {
        clearCart();
        countTotal();
      }
    } else if (productOnCarts.isEmpty) {
      showDialogAction(
        ActionDialog.warning,
        'Anda belum memilih product ',
      );
    } else {
      showDialogAction(
        ActionDialog.warning,
        'Silahkan pilih pelanggan terlebih dahulu',
      );
    }
  }

  personPage() async {
    var data = await Get.toNamed(Routes.customer, arguments: true);
    if (data != null) {
      customer.value = (data as Customer);
      personController.text = customer.value!.name;
      for (var item in productOnCarts) {
        var price = item.unit!.getPrice(
          transactionType!,
          priceType: _getProductPrice(item),
        );
        var point = FuncHelper().pointsCalculation(
          item.onCart,
          price,
          item.dscNominal,
          item.nominalPoint,
          item.pointType,
          item.getSimilarProductOnCart(productOnCarts),
        );
        item.pointsEarned = point;
      }
      countTotal();
    }
  }

  onProductChanged(ProductOnCart data) {
    var productOnCart = productOnCarts.firstWhereOrNull(
      (e) => e.barcode == data.barcode,
    );
    if (productOnCart == null) {
      if (data.onCart != 0) productOnCarts.add(data);
      productList.firstWhere((e) => e.barcode == data.barcode).onCart = 0;
    } else {
      if (data.onCart == 0) {
        productOnCarts.removeWhere((e) => e.barcode == data.barcode);
      } else {
        productOnCart.unit = data.unit;
        productOnCart.onCart = data.onCart;
      }
    }
    countTotal();
  }

  onRemoveFromCart(ProductOnCart data) {
    productOnCarts.removeWhere(
      (e) => e.id == data.id && e.barcode == data.barcode,
    );
    _setIntoBaseData();
    countTotal();
  }

  cartPage() async {
    await Get.to(const TsxProductCartPage());
    refreshData();
    countTotal();
  }

  clearCart() {
    productOnCarts().clear();
    customer.value = null;
    personController.text = '';
    countTotal();
  }

  _setIntoBaseData() {
    for (var item in productList) {
      var productOnCart = productOnCarts.firstWhereOrNull(
        (e) => e.id == item.id && e.barcode == item.barcode,
      );
      if (productOnCart != null) {
        item.unit = productOnCart.unit;
        item.onCart = productOnCart.onCart;
        item.dscNominal = productOnCart.dscNominal;
      }
    }
    productList.refresh();
  }

  countTotal() {
    point.value = 0;
    total.value = 0;
    totalProduct.value = productOnCarts.length;
    for (var item in productOnCarts) {
      var price = item.unit!.getPrice(
        transactionType!,
        priceType: _getProductPrice(item),
      );
      total.value += price * (item.onCart ~/ item.unit!.isi!);
    }

    if (customer.value?.type.isMember ?? false) {
      var productTmp = [...productOnCarts.unique((e) => e.id, false)];
      for (var item in productTmp) {
        point.value += item.pointsEarned;
      }
    }
  }

  ProductPriceType _getProductPrice(ProductOnCart data) {
    var qty = data.onCart;
    var similarProduct = data.getSimilarProductOnCart(productOnCarts);
    var priceType = FuncHelper().getPriceFromCustomerLevels(
      qty,
      customer.value,
      similarProduct,
    );
    return priceType;
  }

  _searchListener() async {
    FuncHelper().searchListener(
      searchController,
      (value) async {
        await refreshData(keyword: value);
      },
    );
  }

  @override
  void onInit() {
    _searchListener();
    refreshData();
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
