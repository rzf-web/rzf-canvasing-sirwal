import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/home/home.controller.dart';
import 'package:rzf_canvasing_sirwal/view/home/widget/app_home_body_parrent.dart';
import 'package:rzf_canvasing_sirwal/view/home/widget/app_home_cashflow_summary.dart';
import 'package:rzf_canvasing_sirwal/view/home/widget/app_home_header.dart';
import 'package:rzf_canvasing_sirwal/view/home/widget/app_home_header_parrent.dart';
import 'package:rzf_canvasing_sirwal/view/home/widget/app_home_menu.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secBgColor,
      body: AppRemoveOverscroll(
        child: RefreshIndicator(
          onRefresh: () async => controller.getReportData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                AppHomeHeaderParrent(
                  child: Column(
                    children: [
                      AppHomeHeader(onTap: controller.logout),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24, top: 10),
                        child: AppHomeMenu(
                          menu: controller.menu,
                          onMenuTap: (route) => controller.onMenuTap(route),
                        ),
                      ),
                    ],
                  ),
                ),
                AppHomeBodyParrent(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0, top: 24.0),
                        child: Obx(
                          () => AppHomeCashFlowSummary(
                            cashIn: controller.cashIn.value,
                            cashOut: controller.cashOut.value,
                            selisih: controller.selisih.value,
                            onSeeAll: () => Get.toNamed(Routes.cashflow),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
