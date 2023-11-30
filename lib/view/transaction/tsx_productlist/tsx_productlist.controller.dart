import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.dart';
import 'package:rzf_canvasing_sirwal/enum/product_unit.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_cart.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_qty_unit_dialog.dart';

class TsxProductListController extends GetxController {
  TransactionType? transactionType;
  final searchController = TextEditingController();
  final refreshController = RefreshController(initialRefresh: false);
  var startPage = 1;
  var lastPage = 1;
  var isLastPage = false.obs;
  var isLoading = false.obs;

  var totalProduct = 0.obs;
  var total = 0.0.obs;
  var productOnCarts = <ProductOnCart>[].obs;
  var productList = <ProductOnCart>[].obs;
  var priceType = ProductUnitPrice.retail.obs;
  Timer? debouncer;
  late Function(List<ProductOnCart>) onSave;

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

  changePriceType(ProductUnitPrice v) {
    priceType.value = v;
    _setIntoBaseData();
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
          priceType: priceType.value,
          onCart: 0,
          initialUnit: null,
          onDone: (qty, unit, group) {
            Get.back();
            onProductChanged(
              product
                ..onCart = qty
                ..unit = unit,
            );
            _setIntoBaseData();
          },
        ),
      );
    } else {
      showSnackbar("Product tidak ditemukan", const Color(0xFFFDBF44));
    }
  }

  onCartSave() {
    onSave(productOnCarts);
  }

  onProductChanged(ProductOnCart data) {
    var productOnCart = productOnCarts.firstWhereOrNull((e) => e.id == data.id);
    if (productOnCart == null) {
      if (data.onCart != 0) productOnCarts.add(data);
      productList.firstWhere((e) => e.id == data.id).onCart = 0;
    } else {
      if (data.onCart == 0) {
        productOnCarts.removeWhere((e) => e.id == data.id);
      } else {
        productOnCart.unit = data.unit;
        productOnCart.onCart = data.onCart;
      }
    }
    _countTotal();
  }

  onRemoveFromCart(ProductOnCart data) {
    productOnCarts.removeWhere((e) => e.id == data.id);
    _setIntoBaseData();
  }

  cartPage() async {
    await Get.to(const TsxProductCartPage());
    refreshData();
    _countTotal();
  }

  clearCart() {
    productOnCarts().clear();
    _countTotal();
  }

  _setIntoBaseData() {
    for (var item in productList) {
      var productOnCart = productOnCarts.firstWhereOrNull(
        (e) => e.id == item.id,
      );
      if (productOnCart != null) {
        item.unit = productOnCart.unit;
        item.onCart = productOnCart.onCart;
        item.dscNominal = productOnCart.dscNominal;
      }
    }
    productList.refresh();
  }

  _countTotal() {
    total.value = 0;
    totalProduct.value = productOnCarts.length;
    for (var item in productOnCarts) {
      var price = item.unit!.getPrice(priceType.value, transactionType!);
      total.value += price * (item.onCart ~/ item.unit!.isi!);
    }
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
