import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';

class AppFixedBottomBtn extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? radius;
  final Color? bgColor;
  final bool showShadow;
  final bool isLoading;
  final Function() onPressed;
  const AppFixedBottomBtn({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
    this.radius = 4,
    this.bgColor,
    this.showShadow = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          boxShadow: [
            if (showShadow)
              const BoxShadow(
                blurRadius: 12,
                color: AppTheme.shadowColor,
                offset: Offset(0, -1),
              )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(padding, 16, padding, padding),
          child: AppButton(
            isLoading: isLoading,
            onPressed: onPressed,
            borderRadius: radius,
            child:
                text != null ? Text(text!, style: AppTheme.btnStyle) : child!,
          ),
        ),
      ),
    );
  }
}
