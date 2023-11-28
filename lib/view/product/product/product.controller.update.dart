import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/model/supplier.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/product/satuan/satuan.page.dart';

class ProductUpdateController extends GetxController {
  final data = Get.arguments;
  final detailFormKey = GlobalKey<FormState>();
  //Product Identity
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final typeController = TextEditingController();
  final rackController = TextEditingController();
  final factoryController = TextEditingController();
  final groupController = TextEditingController();
  final supplierController = TextEditingController();
  //Product Detail Price
  final lastDateBuyController = TextEditingController();
  final satuanController = TextEditingController();
  final buyController = TextEditingController();
  final stokController = TextEditingController();
  final stokMinController = TextEditingController();
  final retailController = TextEditingController();
  final partaiController = TextEditingController();
  final cabangController = TextEditingController();

  var buyPrice = 0.0.obs;
  var retailPrice = 0.0;
  var partaiPrice = 0.0;
  var cabangPrice = 0.0;

  var buyDate = DateTime.now();
  Barcode? barcode;
  var hasBarcode = false.obs;
  var isGetCode = false.obs;
  var productCode = "";
  var group = 'Pribadi'.obs;
  var groups = <String>['Pribadi', 'Npwp'].obs;
  var lastDateBuy = DateTime.now();
  ProductUpdateController();

  onSave() async {
    if (detailFormKey.currentState!.validate()) {
      if (data == null || data is! Product) {
        addProduct();
      } else {
        updateProduct();
      }
    }
  }

  addProduct() async {
    waitingDialog();
    var response = await ApiService.post(
      "$url$productUrl",
      data: _json(),
    );
    Get.back();
    var succes = await manageResponse(response);
    if (succes) {
      Get.back(result: true);
      await manageResponse(response, success: true);
    }
  }

  updateProduct() async {
    waitingDialog();
    var response = await ApiService.put(
      "$url$productUrl",
      data: _json(isEdit: true),
    );
    Get.back();
    var succes = await manageResponse(response);
    if (succes) {
      Get.back(result: idController.text);
    }
  }

  Map<String, dynamic> _json({bool isEdit = false}) {
    return {
      'user_id': GlobalVar.userId,
      'product_id': isEdit ? (data as Product).id : idController.text,
      if (barcode != null) 'product_code': barcode!.code!,
      'product_name': nameController.text,
      'type_name': typeController.text,
      'category_name': categoryController.text,
      'factory': factoryController.text,
      'supplier_name': supplierController.text,
      'rak': rackController.text,
      'stock': stokController.text,
      'stock_min': stokMinController.text,
      'unit_name': satuanController.text,
      'buy': buyPrice.value.toInt(),
      'retail': retailPrice.toInt(),
      'partai': partaiPrice.toInt(),
      'cabang': cabangPrice.toInt(),
      'buy_date': dateFormatAPI(buyDate),
      'npwp': group.value,
    };
  }

  changeGroup(String? v) => group.value = v!;

  getBarCode() async {
    isGetCode.value = true;
    var response = await ApiService.get(
      '$url$productUrl-code',
      queryParameters: getParamQuery(),
    );
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response)['data']['product_code'];
      productCode = data.toString();
      idController.text = productCode;
    }
    isGetCode.value = false;
  }

  scanProduct() async {
    var data = await Get.toNamed(Routes.scannerView);
    if (data != null) {
      barcode = data as Barcode;
      idController.text = barcode!.code!;
    }
    _setHasBarcode();
  }

  clearBarcode() {
    barcode = null;
    idController.text = productCode;
    _setHasBarcode();
  }

  productTypePage() async {
    var data = await Get.toNamed(Routes.productType);
    if (data != null) {
      typeController.text = data;
    }
  }

  rackPage() async {
    var data = await Get.toNamed(Routes.productRack);
    if (data != null) {
      rackController.text = data;
    }
  }

  factoryPage() async {
    var data = await Get.toNamed(Routes.productFactory);
    if (data != null) {
      factoryController.text = data;
    }
  }

  categoryPage() async {
    var data = await Get.toNamed(Routes.productCategory);
    if (data != null) {
      categoryController.text = data;
    }
  }

  satuanPage() async {
    var data = await Get.to(const UnitPage());
    if (data != null) {
      satuanController.text = data;
    }
  }

  supplierPage() async {
    var data = await Get.toNamed(Routes.supplier, arguments: true);
    if (data != null) {
      supplierController.text = (data as Supplier).name;
    }
  }

  onBuyPriceChanged(double value) {
    buyPrice.value = value;
  }

  onBuyRetailChanged(double value) {
    retailPrice = value;
  }

  onBuyPartaiChanged(double value) {
    partaiPrice = value;
  }

  onBuyCabangChanged(double value) {
    cabangPrice = value;
  }

  _setHasBarcode() {
    hasBarcode.value = barcode != null;
  }

  pickDate() {
    showCustomDatePicker((date) {
      buyDate = date;
      lastDateBuyController.text = dateFormatUI(buyDate);
    });
  }

  _initialize() {
    if (data != null && data is Product?) {
      var product = data as Product;
      productCode = product.id!;
      buyDate = product.buyDate;
      buyPrice.value = product.defaultUnit.buy;
      retailPrice = product.defaultUnit.retail;
      partaiPrice = product.defaultUnit.partai;
      group.value = product.group;
      cabangPrice = product.defaultUnit.cabang;
      idController.text = productCode;
      nameController.text = product.name;
      categoryController.text = product.category;
      typeController.text = product.type;
      rackController.text = product.rack;
      factoryController.text = product.factory;
      groupController.text = product.group;
      supplierController.text = product.supplier;
      lastDateBuyController.text = dateFormatUI(buyDate);
      satuanController.text = product.defaultUnit.unit;
      stokController.text = doubleFormatter(product.stock);
      stokMinController.text = doubleFormatter(product.minStock);
      buyController.text = moneyFormatter(buyPrice.value);
      retailController.text = moneyFormatter(retailPrice);
      partaiController.text = moneyFormatter(partaiPrice);
      cabangController.text = moneyFormatter(cabangPrice);
    } else {
      lastDateBuyController.text = dateFormatUI(buyDate);
      getBarCode();
    }
  }

  // _clearForm() {}

  @override
  void onInit() {
    _initialize();
    super.onInit();
  }
}
