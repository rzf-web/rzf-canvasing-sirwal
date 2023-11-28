import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppDetailLabelContent extends StatelessWidget {
  final String label;
  final String content;
  final EdgeInsetsGeometry? margin;
  const AppDetailLabelContent({
    super.key,
    required this.label,
    required this.content,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: const TextStyle(color: AppTheme.capColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
