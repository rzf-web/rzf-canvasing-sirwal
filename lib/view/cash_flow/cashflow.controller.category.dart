import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/cashflow.data.dart';
import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';

class CashflowCategoryController extends GetxController {
  final type = Get.arguments as CashFlowType;
  final searchController = TextEditingController();
  var searchMode = false.obs;
  var isLoading = false.obs;
  var _baseData = <String>[];
  var categories = <String>[].obs;

  getData({bool fromDB = true}) async {
    isLoading.value = true;
    _baseData = await CashFlowData().getCategories(type);
    categories.value = _baseData;
    isLoading.value = false;
  }

  onListTap(String value) {
    Get.back(result: value);
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
