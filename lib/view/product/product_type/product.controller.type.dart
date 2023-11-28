import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.type.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_add_form_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class ProductTypeController extends GetxController {
  final searchController = TextEditingController();
  var searchMode = false.obs;
  var isLoading = false.obs;
  var _baseData = <String>[];
  var types = <String>[].obs;

  getData({bool fromDB = true}) async {
    isLoading.value = true;
    _baseData = await ProductTypeData().fetchApiData();
    types.value = _baseData;
    isLoading.value = false;
  }

  addType(String type) async {
    waitingDialog();
    var response = await ApiService.post(
      "$url$productTypeUrl",
      data: getParamQuery(query: {'type_name': type}),
    );
    Get.back();
    var success = await manageResponse(response, success: true);
    if (success) {
      await getData(fromDB: false);
    }
  }

  updateType(String oldData, String newData) async {
    waitingDialog();
    var response = await ApiService.put(
      "$url$productTypeUrl",
      data: getParamQuery(
        query: {
          //old data
          'type': oldData,
          //new data
          'type_name': newData,
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

  onUpdateType({String? type}) async {
    await showDialogCustom(
      AppAddSingleFormDialog(
        titleDialog: "${type != null ? "Edit" : "Tambah"} Jenis Produk",
        label: "Nama Jenis",
        hintText: "Masukan jenis produk",
        defaultValue: type,
        onSave: (v) {
          Get.back();
          if (type == null) {
            addType(v);
          } else {
            updateType(type, v);
          }
        },
      ),
    );
  }

  onRemove(String value) {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus jenis produk tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          '$url$productTypeUrl',
          data: getParamQuery(
            query: {'type': value},
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
        final searchtype = _baseData.where((e) {
          var titleLower = e.toLowerCase().obs;
          final searchLower = value.toLowerCase();
          return titleLower.contains(searchLower);
        }).toList();
        types.value = searchtype;
      } else {
        types.value = _baseData;
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
