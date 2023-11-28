import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_clear_suffix_icon.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppTextFieldSearchAppBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(PointerDownEvent)? onTapOutside;
  const AppTextFieldSearchAppBar({
    super.key,
    required this.hintText,
    required this.controller,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(color: Color(0xFFD5D8E2)),
    );
    return TextField(
      minLines: 1,
      maxLines: 1,
      maxLength: 29,
      autofocus: true,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.bottom,
      controller: controller,
      onTapOutside: onTapOutside,
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        hintText: hintText,
        counterText: '',
        hintStyle: const TextStyle(color: AppTheme.capColor, fontSize: 14),
        suffixIcon: suffixIcon(),
        prefixIcon: prefixIcon(),
      ),
    );
  }

  Widget prefixIcon() => const SizedBox(
        width: 10,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: AppSvgIcon(
                  svg: svgSearch,
                  size: 16,
                  color: Color(0xFFD5D8E2),
                ),
              ),
            ),
          ],
        ),
      );

  Widget suffixIcon() => AppSuffixIcon(onTap: () => controller!.clear());
}
