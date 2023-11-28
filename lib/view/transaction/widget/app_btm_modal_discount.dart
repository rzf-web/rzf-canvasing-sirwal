import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_number_keyboard.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppBtmModalDiscount extends StatefulWidget {
  final double price;
  final double intitalPercent;
  final double intitalNominal;
  final Function(double, double) onDone;
  const AppBtmModalDiscount({
    super.key,
    required this.price,
    required this.onDone,
    required this.intitalPercent,
    required this.intitalNominal,
  });

  @override
  State<AppBtmModalDiscount> createState() => _AppBtmModalDiscountState();
}

class _AppBtmModalDiscountState extends State<AppBtmModalDiscount> {
  var percentActive = true.obs;
  var percent = 0.0.obs;
  var nominal = 0.0.obs;

  _onChanged(int number) {
    if (percentActive.value) {
      _sumFormPercent(number);
    } else {
      _sumFormNominal(number);
    }
  }

  _sumFormNominal(int number) {
    nominal.value = number.toDouble();
    percent.value = (nominal.value / widget.price) * 100;
  }

  _sumFormPercent(int number) {
    percent.value = number.toDouble();
    nominal.value = (percent.value * widget.price / 100).toDouble();
  }

  @override
  void initState() {
    percent.value = widget.intitalPercent;
    nominal.value = widget.intitalNominal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fieldTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
    );
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
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Discount Produk",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.titleColor,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: fieldInput(
                  onTap: () => {percentActive.value = true},
                  child: Center(
                    child: Obx(
                      () => Text(
                        "${percentFormatter(percent.value)} %",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: fieldTextStyle.copyWith(
                          color: percentActive.value
                              ? AppTheme.titleColor
                              : AppTheme.capColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: fieldInput(
                  onTap: () => {percentActive.value = false},
                  child: Center(
                    child: Obx(
                      () => Text(
                        moneyFormatter(nominal.value),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: fieldTextStyle.copyWith(
                          color: percentActive.value
                              ? AppTheme.capColor
                              : AppTheme.titleColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Obx(
              () => AppNumKeyboard(
                onChanged: _onChanged,
                initial: percentActive.value
                    ? percent.value.toInt()
                    : nominal.value.toInt(),
              ),
            ),
          ),
          AppButton(
            onPressed: () => {
              widget.onDone(percent.value, nominal.value),
              Get.back(),
            },
            child: const Text("Selesai", style: AppTheme.btnStyle),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget fieldInput({required Widget child, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: AppTheme.secBgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: child,
      ),
    );
  }
}
