import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppHomeBodyParrent extends StatelessWidget {
  final Widget child;
  const AppHomeBodyParrent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Stack(
      children: [
        Container(
          height: 30,
          width: double.infinity,
          color: AppTheme.primaryColor,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: padding),
          decoration: const BoxDecoration(
            color: AppTheme.secBgColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: child,
        ),
      ],
    );
  }
}
