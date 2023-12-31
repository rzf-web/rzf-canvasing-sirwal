import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/navigation.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_list_transaction.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_transaction_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class SalePage extends GetView<SaleController> {
  final bool refreshController;
  final bool showLeading;
  const SalePage({
    super.key,
    this.showLeading = true,
    this.refreshController = true,
  });

  @override
  Widget build(BuildContext context) {
    if (refreshController) Get.reload<SaleController>();
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(
            () => AppBarTransaction(
              title: "Data Penjualan",
              hintText: "Nama Pelanggan",
              showLeading: showLeading,
              leading: AppSvgIconBtn(
                svg: svgLogout,
                onTap: controller.logout,
                size: 16,
                color: AppTheme.titleColor,
              ),
              controller: controller.searchController,
              onChangedSearch: controller.changeMode,
              onTap: controller.pickDate,
              searchMode: controller.isFromHome
                  ? NavigationController.isInSearchMode.value
                  : controller.searchMode.value,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.productListPage,
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => AppListTransaction(
            data: controller.saleData(),
            noData: controller.isLastPage.value,
            isLoading: controller.isLoading.value,
            controller: controller.refreshController,
            onRefresh: () => controller.refreshData(),
            onLoading: () => controller.loadData(),
          ),
        ),
      ),
    );
  }
}
