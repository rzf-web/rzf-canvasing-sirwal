import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppSaleSummary extends StatelessWidget {
  final double sale;
  final double receivables;
  const AppSaleSummary({
    super.key,
    required this.sale,
    required this.receivables,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          card(svgMoney, "Penjualan", "Hari ini", sale),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFFEEF2F8),
            margin: const EdgeInsets.symmetric(vertical: 20),
          ),
          card(svgPiutang, "Piutang", "Hari ini", sale),
        ],
      ),
    );
  }

  Widget card(String svg, String title, String subtitle, double total) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AppCardSquare(
            paddingAll: 12,
            child: AppSvgIcon(
              svg: svg,
              size: 24,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.titleColor,
                ),
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: AppTheme.capColor),
            ),
          ],
        ),
        Expanded(
          child: Text(
            moneyFormatter(total),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
