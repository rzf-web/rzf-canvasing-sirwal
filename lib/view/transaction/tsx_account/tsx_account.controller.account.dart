import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/tsx_account.data.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/tsx_account.dart';

class TsxAccountController extends GetxController {
  final searchController = TextEditingController();
  var searchMode = false.obs;
  var isLoading = false.obs;
  var _baseData = <TsxAccount>[];
  var categories = <TsxAccount>[].obs;

  getData({bool fromDB = true}) async {
    isLoading.value = true;
    _baseData = await TsxAccountData().getAccounts();
    categories.value = _baseData;
    isLoading.value = false;
  }

  onListTap(TsxAccount value) {
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
          var titleLower = e.name.toLowerCase().obs;
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
