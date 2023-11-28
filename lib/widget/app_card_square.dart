import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppCardSquare extends StatelessWidget {
  final double? size;
  final double? paddingAll;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  const AppCardSquare({
    super.key,
    required this.child,
    this.paddingAll,
    this.size,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(paddingAll ?? 0),
      margin: margin,
      decoration: BoxDecoration(
        color: AppTheme.secBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
