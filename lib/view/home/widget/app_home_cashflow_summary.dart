import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppHomeCashFlowSummary extends StatelessWidget {
  final double cashIn;
  final double cashOut;
  final double selisih;
  final Function() onSeeAll;
  const AppHomeCashFlowSummary({
    super.key,
    required this.cashIn,
    required this.cashOut,
    required this.selisih,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onSeeAll,
          child: Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(bottom: 18),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Catatan Keuangan",
                  style: TextStyle(fontSize: 16),
                ),
                AppSvgIcon(
                  svg: svgChevronRight,
                  size: 24,
                  color: AppTheme.capColor,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
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
              Container(
                height: 1,
                margin: const EdgeInsets.only(bottom: 12, top: 12),
                width: double.infinity,
                color: AppTheme.borderColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Selisih  ",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.capColor,
                    ),
                  ),
                  Text(
                    moneyFormatter(selisih < 0 ? selisih * -1 : selisih),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: cashIn > cashOut
                          ? const Color(0xFF6AB058)
                          : const Color(0xFFFC6464),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
