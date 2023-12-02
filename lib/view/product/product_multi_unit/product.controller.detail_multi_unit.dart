import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.unit.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/helper/global_style.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/product/satuan/satuan.page.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_multi_unit_form.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class ProductMultiUnitController extends GetxController {
  final data = Get.arguments as Product;
  final priceFormKey = GlobalKey<FormState>();
  final unitController = TextEditingController();
  final isiController = TextEditingController();
  final buyController = TextEditingController();
  final retailController = TextEditingController();
  final partaiController = TextEditingController();
  final cabangController = TextEditingController();

  var isLoading = false.obs;
  var unitPrice = "Harga Retail".obs;
  var multiSat = <ProductUnit>[].obs;
  var isi = 0.0;
  var buyPrice = 0.0.obs;
  var retailPrice = 0.0;
  var partaiPrice = 0.0;
  var cabangPrice = 0.0;

  getMultiUnit() async {
    isLoading.value = true;
    multiSat.value = await ProductUnitData().getProductUnit(data.id!);
    isLoading.value = false;
  }

  onAddProductUnit() async {
    if (priceFormKey.currentState!.validate()) {
      Get.back();
      waitingDialog();
      var response = await ApiService.post(
        url + multisatUrl,
        data: _json(false),
      );
      Get.back();
      var success = await manageResponse(response);
      if (success) {
        waitingDialog(message: 'Sedang Mengambil data mohon tunggu...');
        await getMultiUnit();
        Get.back();
      }
    }
  }

  onUpdateProductUnit(ProductUnit oldData) async {
    if (priceFormKey.currentState!.validate()) {
      if (oldData.unit != data.defaultUnit.unit) {
        Get.back();
        waitingDialog();
        var response = await ApiService.put(
          url + multisatUrl,
          data: _json(true, oldData: oldData),
        );
        Get.back();
        var success = await manageResponse(response);
        if (success) {
          waitingDialog(message: 'Sedang Mengambil data mohon tunggu...');
          await getMultiUnit();
          Get.back();
        }
      } else {
        showDialogAction(
          ActionDialog.warning,
          "Tidak bisa mengubah satuan default",
        );
      }
    }
  }

  onRemove(ProductUnit unit) {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus data tersebut? ",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          url + multisatUrl,
          data: getParamQuery(query: {
            'product_id': data.id,
            'unit': unit.unit,
          }),
        );
        Get.back();
        var success = await manageResponse(response);
        if (success) {
          waitingDialog(message: 'Sedang Mengambil data mohon tunggu...');
          await getMultiUnit();
          Get.back();
        }
      },
    );
  }

  isDefaultUnit(ProductUnit unit) {
    return data.defaultUnit.unit == unit.unit;
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

  unitPage() async {
    var data = await Get.to(const UnitPage());
    if (data != null) {
      unitController.text = data;
    }
  }

  Map<String, dynamic> _json(bool isEdit, {ProductUnit? oldData}) {
    return {
      'user_id': GlobalVar.userId,
      'product_id': data.id,
      if (isEdit) 'unit': oldData!.unit,
      'unit_name': unitController.text,
      'isi': double.parse(isiController.text),
      'buy': buyPrice.value,
      'retail': retailPrice,
      'partai': partaiPrice,
      'cabang': cabangPrice,
    };
  }

  _isiListener() {
    isiController.addListener(() {
      var value = double.tryParse(isiController.text) ?? 0.0;
      buyPrice.value = data.defaultUnit.buy * value;
      retailPrice = data.defaultUnit.retail * value;
      partaiPrice = data.defaultUnit.member * value;
      cabangPrice = data.defaultUnit.grosir3 * value;
      buyController.text = moneyFormatter(buyPrice.value);
      retailController.text = moneyFormatter(retailPrice);
      partaiController.text = moneyFormatter(partaiPrice);
      cabangController.text = moneyFormatter(cabangPrice);
    });
  }

  editMultiUnit({ProductUnit? unit}) async {
    _initProductUnit(unit);
    await showDialogCustom(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: getHeight(Get.context!) * .7,
            maxWidth: getWidth(Get.context!) * .6,
          ),
          child: Obx(
            () => Form(
              key: priceFormKey,
              child: AppAddMultiUnitForm(
                unitPage: unitPage,
                unitController: unitController,
                isiController: isiController,
                buyReadOnly: unit != null,
                buyController: buyController,
                onBuyChanged: onBuyPriceChanged,
                percentageFrom: buyPrice.value,
                retailPrice: retailPrice,
                retailController: retailController,
                onRetailChanged: onBuyRetailChanged,
                partaiPrice: partaiPrice,
                partaiController: partaiController,
                onPartaiChanged: onBuyPartaiChanged,
                cabangPrice: cabangPrice,
                cabangController: cabangController,
                onCabangChanged: onBuyCabangChanged,
                isProductUnit: true,
                onTap: unit == null
                    ? onAddProductUnit
                    : () => onUpdateProductUnit(unit),
              ),
            ),
          ),
        ),
      ),
    );
    isiController.clear();
  }

  _initProductUnit(ProductUnit? unit) {
    if (unit != null) {
      unitController.text = unit.unit;
      unitPrice.value = unit.unit;
      retailPrice = unit.retail;
      partaiPrice = unit.member;
      cabangPrice = unit.grosir3;
      buyPrice.value = unit.buy;
      isiController.text = doubleFormatter(unit.isi!);
      buyController.text = moneyFormatter(buyPrice.value);
      retailController.text = moneyFormatter(retailPrice);
      partaiController.text = moneyFormatter(partaiPrice);
      cabangController.text = moneyFormatter(cabangPrice);
    } else {
      unitController.clear();
      isiController.clear();
      buyController.clear();
      retailController.clear();
      partaiController.clear();
      cabangController.clear();
      buyPrice.value = 0;
      retailPrice = 0;
      partaiPrice = 0;
      cabangPrice = 0;
    }
  }

  @override
  void onInit() {
    _isiListener();
    getMultiUnit();
    super.onInit();
  }
}
