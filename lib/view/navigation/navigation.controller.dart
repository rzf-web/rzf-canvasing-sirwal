import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/view/home/home.page.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.page.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.page.dart';

class NavigationController extends GetxController {
  static var isInSearchMode = false.obs;
  var navIndex = 0.obs;
  var pageIndex = 0.obs;
  var hideMenuLayer = true.obs;
  var pages = <Widget>[
    const HomePage(),
    const BuyPage(showLeading: false, refreshController: false),
    const SalePage(showLeading: false, refreshController: false),
  ];
  var menu = <Map<String, dynamic>>[
    {'icon': svgHouse, 'title': 'Home'},
    {'icon': svgCashOut, 'title': 'Pembelian'},
    {'icon': svgCashIn, 'title': 'Penjualan'},
    {'icon': svgHamburger, 'title': 'Menu'},
  ];

  onNavChanged(int index) {
    navIndex.value = index;
    pageIndex.value = index != 3 ? index : pageIndex.value;
    if (index == 3) hideMenuLayer.value = false;
    if (index == 1) Get.reload<BuyController>();
    if (index == 2) Get.reload<SaleController>();
  }

  onMenuClose() {
    navIndex.value = pageIndex.value;
  }

  onAnimateMenuEnd() async {
    hideMenuLayer.value = !showMenu();
  }

  Future<bool> onGetBack() async {
    if (navIndex.value == 3) {
      onMenuClose();
    } else if (navIndex.value != 0 && !isInSearchMode.value) {
      onNavChanged(0);
    } else if (isInSearchMode.value) {
      isInSearchMode.value = false;
    } else {
      return true;
    }
    return false;
  }

  Widget getPage() {
    return pages[pageIndex.value];
  }

  bool showMenu() {
    return navIndex.value == 3;
  }
}
