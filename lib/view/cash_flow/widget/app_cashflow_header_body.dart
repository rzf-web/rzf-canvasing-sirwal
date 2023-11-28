import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/cashflow.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppCashFlowHeaderBody extends StatefulWidget {
  final String dateTimeUI;
  final double total;
  final List<CashFlow> data;
  final Function(CashFlow) onTap;
  const AppCashFlowHeaderBody({
    super.key,
    required this.dateTimeUI,
    required this.data,
    required this.total,
    required this.onTap,
  });

  @override
  State<AppCashFlowHeaderBody> createState() => _AppCashFlowHeaderBodyState();
}

class _AppCashFlowHeaderBodyState extends State<AppCashFlowHeaderBody> {
  var showData = true.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSize(
        duration: const Duration(milliseconds: 400),
        alignment: Alignment.topCenter,
        curve: Curves.easeIn,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            GestureDetector(
              onTap: () => {showData.value = !showData.value},
              child: header(widget.dateTimeUI, widget.total),
            ),
            if (showData.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.data.map(
                    (e) => Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: widget.data.last.id == e.id ? 8 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () => widget.onTap(e),
                            child: AppCashFlowCard(
                              isLast: widget.data.last.id == e.id,
                              cashFlow: e,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget header(String date, double total) {
    const headerStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppTheme.primaryColor,
    );

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date,
              style: headerStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(moneyFormatter(total), style: headerStyle),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Transform.rotate(
              angle: pi / 2,
              child: const AppSvgIcon(
                svg: svgChevronRight,
                size: 20,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
