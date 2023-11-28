import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.category.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_add_form_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class ProductCategoryController extends GetxController {
  final searchController = TextEditingController();
  var searchMode = false.obs;
  var isLoading = false.obs;
  var _baseData = <String>[];
  var categories = <String>[].obs;

  getData({bool fromDB = true}) async {
    isLoading.value = true;
    _baseData = await ProductCategoryData().fetchApiData();
    categories.value = _baseData;
    isLoading.value = false;
  }

  addCategory(String category) async {
    waitingDialog();
    var response = await ApiService.post(
      "$url$categoryProductUrl",
      data: getParamQuery(query: {'category_name': category}),
    );
    Get.back();
    var success = await manageResponse(response, success: true);
    if (success) {
      await getData(fromDB: false);
    }
  }

  updateCategory(String oldData, String newData) async {
    waitingDialog();
    var response = await ApiService.put(
      "$url$categoryProductUrl",
      data: getParamQuery(
        query: {
          //old data
          'category': oldData,
          //new data
          'category_name': newData,
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

  onUpdateCategory({String? category}) async {
    await showDialogCustom(
      AppAddSingleFormDialog(
        titleDialog: "${category != null ? "Edit" : "Tambah"} Kategori Produk",
        label: "Nama Kategori",
        hintText: "Masukan kategori produk",
        defaultValue: category,
        onSave: (v) {
          Get.back();
          if (category == null) {
            addCategory(v);
          } else {
            updateCategory(category, v);
          }
        },
      ),
    );
  }

  onRemove(String value) {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus kategori produk tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          '$url$categoryProductUrl',
          data: getParamQuery(
            query: {'category': value},
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
        final searchCategory = _baseData.where((e) {
          var titleLower = e.toLowerCase().obs;
          final searchLower = value.toLowerCase();
          return titleLower.contains(searchLower);
        }).toList();
        categories.value = searchCategory;
      } else {
        categories.value = _baseData;
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
