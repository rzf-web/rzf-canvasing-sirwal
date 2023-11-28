import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.rack.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_add_form_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class ProductRackController extends GetxController {
  final searchController = TextEditingController();
  var searchMode = false.obs;
  var isLoading = false.obs;
  var _baseData = <String>[];
  var racks = <String>[].obs;

  getData({bool fromDB = true}) async {
    isLoading.value = true;
    _baseData = await ProductRacksData().fetchApiData();
    racks.value = _baseData;
    isLoading.value = false;
  }

  addRack(String rack) async {
    waitingDialog();
    var response = await ApiService.post(
      "$url$rackUrl",
      data: getParamQuery(query: {'rak_name': rack}),
    );
    Get.back();
    var success = await manageResponse(response, success: true);
    if (success) {
      await getData(fromDB: false);
    }
  }

  updateRack(String oldData, String newData) async {
    waitingDialog();
    var response = await ApiService.put(
      "$url$rackUrl",
      data: getParamQuery(
        query: {
          //old data
          'rak': oldData,
          //new data
          'rak_name': newData,
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

  onUpdateRack({String? rack}) async {
    await showDialogCustom(
      AppAddSingleFormDialog(
        titleDialog: "${rack != null ? "Edit" : "Tambah"} Rak Produk",
        label: "Nama Rak",
        hintText: "Masukan rak produk",
        defaultValue: rack,
        onSave: (v) {
          Get.back();
          if (rack == null) {
            addRack(v);
          } else {
            updateRack(rack, v);
          }
        },
      ),
    );
  }

  onRemove(String value) {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus rak produk tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          '$url$rackUrl',
          data: getParamQuery(
            query: {'rak': value},
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
        final searchRack = _baseData.where((e) {
          var titleLower = e.toLowerCase().obs;
          final searchLower = value.toLowerCase();
          return titleLower.contains(searchLower);
        }).toList();
        racks.value = searchRack;
      } else {
        racks.value = _baseData;
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
