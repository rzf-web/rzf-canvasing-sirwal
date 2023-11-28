import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppPinDot extends StatelessWidget {
  final bool isActive;
  final bool isLast;
  const AppPinDot({super.key, required this.isActive, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      margin: EdgeInsets.only(right: isLast ? 0 : 12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? Colors.transparent : const Color(0xFF94A0B4),
        ),
        color: isActive ? AppTheme.primaryColor : Colors.transparent,
        shape: BoxShape.circle,
      ),
    );
  }
}
