import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_chart_indicator.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_report_periodic.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_summary.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashinout_summary.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class CashReportView extends GetView<CashFlowController> {
  const CashReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.secBgColor,
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AppRemoveOverscroll(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AppCashflowReportPriode(
                    onChanged: controller.changeDateReport,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Obx(
                    () => AppCashFlowSummary(
                      selisih: controller.selisihSummary.value,
                      cashIn: controller.cashInSummary.value,
                      cashOut: controller.cashOutSummary.value,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 16),
                  child: Obx(
                    () => AppCashFlowIndicator(
                      percent: controller.percent.value,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TabBar(
                    controller: controller.tabControllerReport,
                    indicatorColor: AppTheme.primaryColor,
                    labelColor: AppTheme.primaryColor,
                    tabs: const [
                      Tab(text: 'Pemasukan'),
                      Tab(text: 'Pengeluaran'),
                    ],
                  ),
                ),
                Obx(
                  () => AppCashInOutSummary(
                    cashFlowType: controller.reportSummaryIndex.value == 0
                        ? CashFlowType.cashin
                        : CashFlowType.cashout,
                    data: controller.reportSummaryIndex.value == 0
                        ? controller.cashInReport()
                        : controller.cashOutReport(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
