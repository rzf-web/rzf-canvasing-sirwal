import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppTextFieldAuth extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  const AppTextFieldAuth({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      keyboardType: isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: const Color(0x33C4C4C4),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF000000).withOpacity(.5),
        ),
        suffixIcon: Container(
          color: Colors.transparent,
          width: 24,
          height: 24,
          child: Stack(
            children: [
              Center(
                child: AppSvgIcon(
                  svg: isPassword ? svgLock : svgMail,
                  size: 24,
                  color: const Color(0xFF000000).withOpacity(.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
