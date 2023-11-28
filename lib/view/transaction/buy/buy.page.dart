import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/navigation.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_list_transaction.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_transaction_appbar.dart';

class BuyPage extends GetView<BuyController> {
  final bool showLeading;
  final bool refreshController;
  const BuyPage({
    super.key,
    this.showLeading = true,
    this.refreshController = true,
  });

  @override
  Widget build(BuildContext context) {
    if (refreshController) Get.reload<BuyController>();
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(
            () => AppBarTransaction(
              title: "Data Pembelian",
              hintText: "Nama Supplier",
              showLeading: showLeading,
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
            data: controller.buyData(),
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
