import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppCashFlowSummary extends StatelessWidget {
  final double selisih;
  final double cashIn;
  final double cashOut;
  const AppCashFlowSummary({
    super.key,
    required this.cashIn,
    required this.cashOut,
    required this.selisih,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            "Selisih",
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.capColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            moneyFormatter(selisih),
            style: const TextStyle(
              fontSize: 18,
              color: AppTheme.titleColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.only(bottom: 12),
          width: double.infinity,
          color: AppTheme.borderColor,
        ),
        Row(
          children: [
            Expanded(child: cashInOut(CashFlowType.cashin, cashIn)),
            Container(
              height: 40,
              width: 1,
              color: AppTheme.borderColor,
            ),
            Expanded(child: cashInOut(CashFlowType.cashout, cashOut)),
          ],
        ),
      ],
    );
  }

  Widget cashInOut(CashFlowType type, double nominal) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: pi / (type.isCashIn ? 2 : -2),
              child: AppSvgIcon(
                svg: svgArrowLeft,
                size: 12,
                color: type.isCashIn
                    ? const Color(0xFF6AB058)
                    : const Color(0xFFFC6464),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                type.nameLocale,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.capColor,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            moneyFormatter(nominal),
            style: TextStyle(
              color: type.isCashIn
                  ? const Color(0xFF6AB058)
                  : const Color(0xFFFC6464),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
