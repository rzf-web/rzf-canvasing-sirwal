import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/cashflow.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppCashFlowCard extends StatelessWidget {
  final bool isLast;
  final CashFlow cashFlow;
  final String? caption;
  const AppCashFlowCard({
    super.key,
    required this.isLast,
    required this.cashFlow,
    this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardList(
      isLast: isLast,
      marginPadding: 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(right: 14),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secBgColor,
            ),
            child: Center(
              child: AppSvgIcon(
                svg: cashFlow.type.isCashIn ? svgCashIn : svgCashOut,
                size: 16,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cashFlow.type.nameLocale,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.titleColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: SizedBox(
                        width: 80,
                        child: Text(
                          moneyFormatter(cashFlow.type.isCashIn
                              ? cashFlow.cashin
                              : cashFlow.cashout),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.titleColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    caption ?? cashFlow.note,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.capColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
