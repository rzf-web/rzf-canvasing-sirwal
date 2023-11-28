import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class AppTsxSearchScan extends StatelessWidget {
  final TextEditingController controller;
  final Function() onBtnClick;
  const AppTsxSearchScan({
    super.key,
    required this.controller,
    required this.onBtnClick,
  });

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: AppTextFieldInput(
              label: "Cari Produk / Scan Barcode",
              hintText: "Cari produk",
              controller: controller,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 47,
            height: 47,
            child: AppButton(
              onPressed: onBtnClick,
              borderRadius: 4,
              child: const AppSvgIcon(
                size: 34,
                svg: svgQrcode,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
