import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_list.dart';

class CashOutView extends GetView<CashFlowController> {
  const CashOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppCashFlowList(
        data: controller.cashOut(),
        onRefresh: controller.getData,
      ),
    );
  }
}
