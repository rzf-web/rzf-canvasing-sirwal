import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/model/cashflow.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_header_body.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class AppCashFlowList extends GetView<CashFlowController> {
  final List<CashFlowUI> data;
  final Function() onRefresh;
  const AppCashFlowList({
    super.key,
    required this.data,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Obx(
      () => Stack(
        children: [
          if (data.isEmpty && !controller.isLoading.value)
            const AppDataNotFound(message: "Data tidak ada"),
          if (controller.isLoading.value)
            const AppLoading()
          else
            AppRemoveOverscroll(
              child: RefreshIndicator(
                onRefresh: () => onRefresh(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: ListView(
                    children: [
                      const SizedBox(height: 12),
                      ...data.map(
                        (e) => AppCashFlowHeaderBody(
                          dateTimeUI: e.header,
                          total: e.total,
                          data: e.data,
                          onTap: (v) => controller.updateCashFlowPage(data: v),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
