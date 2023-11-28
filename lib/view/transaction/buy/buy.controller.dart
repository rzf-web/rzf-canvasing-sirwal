import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rzf_canvasing_sirwal/data/buy.data.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/buy.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/navigation.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/transaction_class.controller.dart';

class BuyController extends GetxController implements TsxListController {
  final searchController = TextEditingController();
  final refreshController = RefreshController(initialRefresh: false);
  var startDate = DateTime.now();
  var endDate = DateTime.now();
  var buyData = <Map<String, dynamic>>[].obs;
  var searchMode = false.obs;
  var isLoading = false.obs;
  var isFromHome = false;
  var isLastPage = false.obs;

  var startPage = 1;
  var lastPage = 0;
  BuyController({this.isFromHome = false});

  @override
  Future<List<Buy>> getData() async {
    var data = await BuyData().fetchApiData(
      supplier: searchController.text,
      startDate: dateFormatAPI(startDate),
      endDate: dateFormatAPI(endDate),
      startPage: startPage,
    );
    lastPage = data['last_page'];
    isLastPage.value = startPage >= lastPage;
    startPage++;
    return data['data'];
  }

  @override
  Future refreshData() async {
    startPage = 1;
    isLoading.value = true;
    var data = await getData();
    buyData.clear();
    for (var item in data) {
      buyData.add(item.toMapList());
    }
    isLoading.value = false;
    refreshController.refreshCompleted();
  }

  @override
  loadData() async {
    var data = await getData();
    for (var item in data) {
      buyData.add(item.toMapList());
    }
    refreshController.loadComplete();
  }

  @override
  void productListPage() {
    Get.toNamed(Routes.buyAdd);
  }

  changeMode() {
    if (isFromHome) {
      var oldValue = NavigationController.isInSearchMode.value;
      NavigationController.isInSearchMode.value = !oldValue;
    } else {
      searchMode.value = !searchMode.value;
    }
  }

  pickDate(start, end) {
    startDate = start;
    endDate = end;
    refreshData();
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
    FuncHelper()
        .searchListener(searchController, (v) async => await refreshData());
  }

  _initialize() {
    var now = DateTime.now();
    startDate = DateTime(now.year, now.month, 1);
    endDate = DateTime(now.year, now.month + 1, 0);
    _listener();
  }

  @override
  void onInit() {
    _initialize();
    refreshData();
    super.onInit();
  }
}
