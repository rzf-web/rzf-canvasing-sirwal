import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_list.dart';

class CashInView extends GetView<CashFlowController> {
  const CashInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppCashFlowList(
        data: controller.cashIn(),
        onRefresh: controller.getData,
      ),
    );
  }
}
