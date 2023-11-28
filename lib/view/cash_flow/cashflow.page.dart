import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/view/cashin.view.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/view/cashout.view.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/view/cashreport.view.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_tabbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_date_report.dart';

class CashFlowPage extends GetView<CashFlowController> {
  const CashFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: "Cash Flow",
        showBorder: false,
        actions: [
          Obx(() => controller.showAddBtn.value
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppDateReport(onSubmit: controller.pickDate),
                )
              : const SizedBox())
        ],
      ),
      floatingActionButton: Obx(
        () => controller.showAddBtn.value
            ? FloatingActionButton(
                onPressed: controller.updateCashFlowPage,
                child: const Icon(Icons.add))
            : const SizedBox(),
      ),
      body: Column(
        children: [
          AppCashFlowTabbar(
            tabBars: const ['Pemasukan', 'Pengeluaran', 'Laporan'],
            controller: controller.tabControllerFilter,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabControllerFilter,
              children: const [
                CashInView(),
                CashOutView(),
                CashReportView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
