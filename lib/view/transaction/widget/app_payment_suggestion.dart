import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_currency_keyboard.dart';

class AppPaymentSuggestion extends StatelessWidget {
  final List<int> moneySuggestion;
  final Function(double) onSuggestionTap;
  const AppPaymentSuggestion({
    super.key,
    required this.moneySuggestion,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...moneySuggestion.map(
                (e) => SizedBox(
                  width: constraints.maxWidth * .31,
                  child: suggestionCard(
                    moneyFormatter(e.toDouble()),
                    () => onSuggestionTap(e.toDouble()),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: constraints.maxWidth * .31,
              child: suggestionCard(
                "Lainnya",
                () => showBottomBar(
                  AppDialogCurrencyKeyboard(
                    title: "Jumlah Pembayaran",
                    onDone: (money) => {onSuggestionTap(money), Get.back()},
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget suggestionCard(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.secBgColor,
          border: Border.all(
            color: AppTheme.textFieldBorderColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
