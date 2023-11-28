import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/home/widget/app_home_bg.dart';

class AppHomeHeaderParrent extends StatelessWidget {
  final Widget child;
  const AppHomeHeaderParrent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor,
      child: SafeArea(
        child: Stack(
          children: [
            const AppHomeBg(),
            child,
          ],
        ),
      ),
    );
  }
}
