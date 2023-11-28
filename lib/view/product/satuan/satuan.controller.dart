import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.unit.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_add_form_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class UnitController extends GetxController {
  final searchController = TextEditingController();
  var searchMode = false.obs;
  var isLoading = false.obs;
  var _baseData = <String>[];
  var units = <String>[].obs;

  getData({bool fromDB = true}) async {
    isLoading.value = true;
    _baseData = await ProductUnitData().fetchApiData();
    units.value = _baseData;
    isLoading.value = false;
  }

  addSatuan(String unit) async {
    waitingDialog();
    var response = await ApiService.post(
      "$url$unitUrl",
      data: getParamQuery(query: {'unit_name': unit}),
    );
    Get.back();
    var success = await manageResponse(response, success: true);
    if (success) {
      await getData(fromDB: false);
    }
  }

  updateSatuan(String oldData, String newData) async {
    waitingDialog();
    var response = await ApiService.put(
      "$url$unitUrl",
      data: getParamQuery(
        query: {
          //old data
          'unit': oldData,
          //new data
          'unit_name': newData,
        },
      ),
    );
    Get.back();
    var success = await manageResponse(response, success: true);
    if (success) {
      await getData(fromDB: false);
    }
  }

  onListTap(String value) {
    Get.back(result: value);
  }

  onUpdateSatuan({String? satuan}) async {
    await showDialogCustom(
      AppAddSingleFormDialog(
        titleDialog: "${satuan != null ? "Edit" : "Tambah"} Satuan Produk",
        label: "Nama Satuan",
        hintText: "Masukan satuan produk",
        defaultValue: satuan,
        onSave: (v) {
          Get.back();
          if (satuan == null) {
            addSatuan(v);
          } else {
            updateSatuan(satuan, v);
          }
        },
      ),
    );
  }

  onRemove(String value) {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus satuan produk tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          '$url$unitUrl',
          data: getParamQuery(
            query: {'unit': value},
          ),
        );
        Get.back();
        var succes = await manageResponse(response);
        if (succes) {
          await getData(fromDB: false);
        }
      },
    );
  }

  changeMode() {
    searchMode.value = !searchMode.value;
  }

  Future<bool> onWillPop() async {
    if (searchMode.value) {
      searchMode.value = false;
      searchController.clear();
      return false;
    } else {
      return true;
    }
  }

  _listener() {
    FuncHelper().searchListener(searchController, (value) {
      if (value != "") {
        final searchUnit = _baseData.where((e) {
          var titleLower = e.toLowerCase().obs;
          final searchLower = value.toLowerCase();
          return titleLower.contains(searchLower);
        }).toList();
        units.value = searchUnit;
      } else {
        units.value = _baseData;
      }
    });
  }

  @override
  void onInit() {
    getData();
    _listener();
    super.onInit();
  }
}
