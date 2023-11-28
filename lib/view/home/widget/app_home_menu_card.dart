import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppHomeMenuCard extends StatelessWidget {
  final String svg;
  final String title;
  final Function() onTap;
  const AppHomeMenuCard({
    super.key,
    required this.svg,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppTheme.secBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppSvgIcon(
              svg: svg,
              size: 24,
              color: AppTheme.primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ],
      ),
    );
  }
}
