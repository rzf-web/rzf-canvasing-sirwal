import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rzf_canvasing_sirwal/data/supplier.data.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/supplier.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';

class SupplierController extends GetxController {
  final isFromProduct = Get.arguments;
  final searchController = TextEditingController();
  final refreshController = RefreshController(initialRefresh: false);

  var startPage = 1;
  var lastPage = 1;
  var isLastPage = false.obs;
  var searchMode = false.obs;
  var isLoading = false.obs;
  var suppliers = <Supplier>[].obs;

  Future<List<Supplier>> _getSuppliers({String? keyword}) async {
    var data = await SupplierData().fetchApiData(
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
    suppliers.value = await _getSuppliers(keyword: keyword);
    isLoading.value = false;
    refreshController.refreshCompleted();
  }

  loadData() async {
    suppliers.value += await _getSuppliers();
    refreshController.loadComplete();
  }

  changeMode() {
    searchMode.value = !searchMode.value;
  }

  supplierUpdatePage() async {
    var updated = await Get.toNamed(Routes.supplierUpdate);
    if (updated != null) await _getSuppliers();
  }

  supplierDetailPage(Supplier supplier) async {
    if (isFromProduct != null) {
      Get.back(result: supplier);
    } else {
      await Get.toNamed(Routes.supplierDetail, arguments: supplier);
      await _getSuppliers();
    }
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

  Supplier getLastData() {
    return suppliers.last;
  }

  _searchListener() {
    FuncHelper().searchListener(
      searchController,
      (v) async => await refreshData(keyword: v),
    );
  }

  @override
  Future<void> onInit() async {
    _searchListener();
    await refreshData();
    super.onInit();
  }
}
