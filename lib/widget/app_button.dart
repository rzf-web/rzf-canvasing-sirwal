import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_ink_well.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading_button.dart';

class AppButton extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final bool isOutline;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxBorder? border;

  final Function() onPressed;

  const AppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.border,
    this.margin,
    this.padding,
    this.isLoading = false,
    this.borderRadius,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    var colorBtn = color ?? AppTheme.primaryColor;
    return Container(
      width: double.infinity,
      height: 48,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : colorBtn,
        border: isOutline ? Border.all(color: colorBtn) : border,
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      child: isLoading ? btnLoading() : buttonContent(),
    );
  }

  Widget buttonContent() {
    return Stack(
      children: [
        Center(child: child),
        AppInkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          onTap: onPressed,
        )
      ],
    );
  }

  Widget btnLoading() {
    return const AppLoadingBtn();
  }
}
