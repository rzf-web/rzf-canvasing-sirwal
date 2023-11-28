import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppTextFieldInput extends StatefulWidget {
  final String label;
  final String hintText;
  final String? initialValue;
  final bool numberOnly;
  final bool readOnly;
  final bool readOnlyDifColor;
  final bool isCurrency;
  final bool withCurrencyPercentage;
  final bool pricePercentage;
  final bool obscureText;
  final double percentageFrom;
  final double? initialCurrency;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final Function(double)? onCurrencyChanged;
  final String? Function(String?)? validator;
  const AppTextFieldInput({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.onCurrencyChanged,
    this.numberOnly = false,
    this.readOnly = false,
    this.isCurrency = false,
    this.withCurrencyPercentage = false,
    this.percentageFrom = 0.0,
    this.pricePercentage = true,
    this.readOnlyDifColor = false,
    this.initialValue,
    this.initialCurrency,
    this.textInputAction,
    this.obscureText = false,
  });

  @override
  State<AppTextFieldInput> createState() => _AppTextFieldInputState();
}

class _AppTextFieldInputState extends State<AppTextFieldInput> {
  final percentController = TextEditingController();
  var obscureText = false.obs;
  var currencyFormatter = CurrencyTextInputFormatter(
    symbol: "Rp",
    locale: 'id',
    decimalDigits: 0,
  );
  var percentage = "0".obs;

  countPercentage() {
    var currency = currencyFormatter.getUnformattedValue().toDouble();
    if (widget.percentageFrom != 0 && currency > 0) {
      var selisih = currency - widget.percentageFrom;
      var percentage = (selisih / widget.percentageFrom) * 100;
      this.percentage.value = checkPercentage(percentage).toString();
    } else {
      percentage.value = "";
      widget.controller!.text = currencyFormatter.format('0');
    }
  }

  countPercentageForm() {
    var currency = currencyFormatter.getUnformattedValue().toDouble();
    if (widget.percentageFrom != 0 && widget.controller!.text != '') {
      var percentage = (currency / widget.percentageFrom) * 100;
      this.percentage.value = checkPercentage(percentage).toString();
    } else {
      percentage.value = "";
      widget.controller!.text = currencyFormatter.format('0');
    }
  }

  checkPercentage(double value) {
    if (value - value.toInt() == 0) {
      return value.toInt();
    } else {
      return double.parse(value.toStringAsFixed(2));
    }
  }

  _sumFromPercent(String v) {
    var percent = double.tryParse(v) ?? 0;
    if (percent != 0) {
      var source = widget.percentageFrom;
      var margin = ((percent * source.toInt() / 100) + source).toInt();
      widget.controller!.text = currencyFormatter.format(margin.toString());
    } else {
      widget.controller!.text = currencyFormatter.format('0');
    }
  }

  @override
  void initState() {
    obscureText.value = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.withCurrencyPercentage) {
      if (widget.initialCurrency != null) {
        currencyFormatter.format(widget.initialCurrency!.toInt().toString());
      }
      countPercentage();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.titleColor,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.withCurrencyPercentage)
              Container(
                width: 47,
                height: 47,
                margin: const EdgeInsets.only(right: 8),
                child: Obx(
                  () => TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    controller: percentController
                      ..text = percentage.value.toString(),
                    style:
                        const TextStyle(color: Color(0xFF717E95), fontSize: 14),
                    onChanged: (v) => {
                      _sumFromPercent(v),
                      widget.onCurrencyChanged!(
                        currencyFormatter.getUnformattedValue().toDouble(),
                      ),
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                    ],
                    maxLines: 1,
                    decoration: AppTheme.textFieldInputDecoration.copyWith(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      hintStyle: const TextStyle(
                          color: Color(0xFF717E95), fontSize: 14),
                      hintText: "0",
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Obx(
                () => TextFormField(
                  readOnly: widget.readOnly,
                  validator: widget.validator,
                  controller: widget.controller,
                  initialValue: widget.initialValue,
                  onTap: widget.onTap,
                  textInputAction: widget.textInputAction,
                  obscureText: obscureText.value,
                  keyboardType: widget.numberOnly || widget.isCurrency
                      ? TextInputType.phone
                      : TextInputType.name,
                  onChanged: (v) {
                    if (widget.isCurrency) {
                      if (widget.onCurrencyChanged != null) {
                        widget.onCurrencyChanged!(
                          currencyFormatter.getUnformattedValue().toDouble(),
                        );
                      }
                      if (widget.withCurrencyPercentage) {
                        if (widget.pricePercentage) {
                          countPercentage();
                        } else {
                          countPercentageForm();
                        }
                      }
                    }
                  },
                  inputFormatters: [
                    if (widget.numberOnly)
                      FilteringTextInputFormatter.digitsOnly,
                    if (widget.isCurrency) currencyFormatter,
                  ],
                  decoration: AppTheme.textFieldInputDecoration.copyWith(
                    filled: widget.readOnly && widget.readOnlyDifColor,
                    fillColor: const Color(0xFFEEF2F8),
                    hintText: widget.hintText,
                    suffixIcon: widget.suffixIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
