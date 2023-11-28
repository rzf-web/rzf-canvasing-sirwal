import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_number_keyboard.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppDialogCurrencyKeyboard extends StatefulWidget {
  final String title;
  final bool onlyNumber;
  final Function(double) onDone;
  const AppDialogCurrencyKeyboard({
    super.key,
    required this.title,
    required this.onDone,
    this.onlyNumber = false,
  });

  @override
  State<AppDialogCurrencyKeyboard> createState() =>
      _AppDialogCurrencyKeyboardState();
}

class _AppDialogCurrencyKeyboardState extends State<AppDialogCurrencyKeyboard> {
  var money = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.topRight,
            child: AppSvgIconBtn(
              svg: svgClose,
              color: AppTheme.capColor,
              onTap: Get.back,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.titleColor,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: AppTheme.secBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  widget.onlyNumber
                      ? '${money.value.toInt()}'
                      : moneyFormatter(money.value),
                  style: const TextStyle(
                    color: AppTheme.titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: AppNumKeyboard(onChanged: (v) => money.value = v.toDouble()),
          ),
          AppButton(
            onPressed: () {
              widget.onDone(money.value);
            },
            child: const Text("Selesai", style: AppTheme.btnStyle),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
