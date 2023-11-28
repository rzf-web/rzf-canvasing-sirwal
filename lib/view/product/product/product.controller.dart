import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';

class ProductController extends GetxController {
  final searchController = TextEditingController();
  final refreshController = RefreshController(initialRefresh: false);

  var startPage = 1;
  var lastPage = 1;
  var isLastPage = false.obs;
  var searchMode = false.obs;
  var isLoading = false.obs;
  var products = <Product>[].obs;

  Future<List<Product>> _getDataProduct({String keyword = ''}) async {
    var data = await ProductData().fetchApiData(
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
    products.value = await _getDataProduct(keyword: keyword);
    isLoading.value = false;
    refreshController.refreshCompleted();
  }

  loadData() async {
    products.value += await _getDataProduct();
    refreshController.loadComplete();
  }

  updateProductPage() async {
    await Get.toNamed(Routes.productUpdate);
    await refreshData();
  }

  productDetailPage(Product product) async {
    await Get.toNamed(Routes.productDetail, arguments: product);
    await refreshData();
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

  _searchListener() {
    FuncHelper().searchListener(
      searchController,
      (value) => refreshData(keyword: value),
    );
  }

  @override
  void onInit() {
    _searchListener();
    refreshData();
    super.onInit();
  }
}
