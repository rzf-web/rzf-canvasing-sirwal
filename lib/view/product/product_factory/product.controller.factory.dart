import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.factory.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_add_form_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class ProductFactoryController extends GetxController {
  final searchController = TextEditingController();
  var searchMode = false.obs;
  var isLoading = false.obs;
  var _baseData = <String>[];
  var factories = <String>[].obs;

  getData({bool fromDB = true}) async {
    isLoading.value = true;
    _baseData = await ProductFactoriesData().fetchApiData();
    factories.value = _baseData;
    isLoading.value = false;
  }

  addFactory(String factory) async {
    waitingDialog();
    var response = await ApiService.post(
      "$url$factoryUrl",
      data: getParamQuery(query: {'factory_name': factory}),
    );
    Get.back();
    var success = await manageResponse(response, success: true);
    if (success) {
      await getData(fromDB: false);
    }
  }

  updateFactory(String oldData, String newData) async {
    waitingDialog();
    var response = await ApiService.put(
      "$url$factoryUrl",
      data: getParamQuery(
        query: {
          //old data
          'factory': oldData,
          //new data
          'factory_name': newData,
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

  onUpdateFactory({String? factory}) async {
    await showDialogCustom(
      AppAddSingleFormDialog(
        titleDialog: "${factory != null ? "Edit" : "Tambah"} Pabrik Produk",
        label: "Nama Pabrik",
        hintText: "Masukan pabrik produk",
        defaultValue: factory,
        onSave: (v) {
          Get.back();
          if (factory == null) {
            addFactory(v);
          } else {
            updateFactory(factory, v);
          }
        },
      ),
    );
  }

  onRemove(String value) {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus pabrik tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          '$url$factoryUrl',
          data: getParamQuery(
            query: {'factory': value},
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
        final searchFactory = _baseData.where((e) {
          var titleLower = e.toLowerCase().obs;
          final searchLower = value.toLowerCase();
          return titleLower.contains(searchLower);
        }).toList();
        factories.value = searchFactory;
      } else {
        factories.value = _baseData;
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
