import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.controller.dart';
import 'package:rzf_canvasing_sirwal/view/customer/widget/app_customer_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_smart_refresh.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_search.dart';

class CustomerPage extends GetView<CustomerController> {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(
            () => AppCustomAppBar(
              showLeading: true,
              hideAppBar: controller.searchMode.value,
              title: "Data Pelanggan",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: AppSvgIconBtn(
                    svg: svgSearch,
                    size: 16,
                    color: AppTheme.titleColor,
                    onTap: controller.changeMode,
                  ),
                )
              ],
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: 8,
                ),
                child: Center(
                  child: AppTextFieldSearchAppBar(
                    hintText: "Cari Pelanggan",
                    controller: controller.searchController,
                  ),
                ),
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: controller.customerUpdatePage,
        //   child: const Icon(Icons.add),
        // ),
        body: Obx(
          () => Stack(
            children: [
              if (controller.customers().isEmpty && !controller.isLoading.value)
                const AppDataNotFound(),
              if (controller.isLoading.value)
                const AppLoading()
              else
                AppRemoveOverscroll(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: padding),
                    child: AppSmartRefresh(
                      onRefresh: () => controller.refreshData(),
                      onLoading: () => controller.loadData(),
                      controller: controller.refreshController,
                      noData: controller.isLastPage.value,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 20),
                          ...controller.customers().map(
                                (e) => AppCustomerCard(
                                  customer: e,
                                  isLast: controller.getLastData().id == e.id,
                                  onTap: () => controller.customerDetailPage(e),
                                ),
                              ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
