import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppDropDown extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final bool isLoading;
  final List<String> items;
  final Function(String?)? onChanged;
  final Decoration? decoration;
  const AppDropDown({
    super.key,
    this.value,
    required this.items,
    required this.hintText,
    required this.label,
    this.onChanged,
    this.decoration,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.titleColor,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: AppTheme.textFieldBorderColor),
              ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              elevation: 1,
              isDense: true,
              isExpanded: true,
              hint: Text(
                hintText,
                style: const TextStyle(color: AppTheme.capColor, fontSize: 16),
              ),
              style: const TextStyle(
                fontSize: 14,
                fontFamily: AppTheme.fontFamily,
              ),
              value: value,
              items: items.map((e) => buildMenuItem(e)).toList(),
              icon: suffixIcon(),
              onChanged: isLoading ? null : onChanged,
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.titleColor,
            fontFamily: AppTheme.fontFamily,
          ),
        ),
      );
  Widget suffixIcon() {
    if (isLoading) {
      return const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      return Center(
        child: Transform.rotate(
          angle: pi / 2,
          child: const AppSvgIcon(
            svg: svgChevronRight,
            size: 24,
            color: AppTheme.capColor,
          ),
        ),
      );
    }
  }
}
