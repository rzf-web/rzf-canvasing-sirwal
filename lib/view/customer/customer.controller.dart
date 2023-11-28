import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rzf_canvasing_sirwal/data/customer.data.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';

class CustomerController extends GetxController {
  final isPickData = Get.arguments ?? false;
  final searchController = TextEditingController();
  final refreshController = RefreshController(initialRefresh: false);

  var startPage = 1;
  var lastPage = 1;
  var isLastPage = false.obs;
  var searchMode = false.obs;
  var isLoading = false.obs;
  var customers = <Customer>[].obs;

  Future<List<Customer>> _getCustomers({String? keyword}) async {
    var data = await CustomerData().fetchApiData(
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
    customers.value = await _getCustomers(keyword: keyword);
    isLoading.value = false;
    refreshController.refreshCompleted();
  }

  loadData() async {
    customers.value += await _getCustomers();
    refreshController.loadComplete();
  }

  changeMode() {
    searchMode.value = !searchMode.value;
  }

  customerUpdatePage() {
    Get.toNamed(Routes.customerUpdate);
  }

  customerDetailPage(Customer customer) {
    if (isPickData) {
      Get.back(result: customer);
    } else {
      Get.toNamed(Routes.customerDetail, arguments: customer);
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

  Customer getLastData() {
    return customers.last;
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
