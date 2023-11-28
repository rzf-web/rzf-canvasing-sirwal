import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppLoading extends StatelessWidget {
  final double? indicatorSize;
  final double? fontSize;
  const AppLoading({super.key, this.indicatorSize, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: indicatorSize,
            width: indicatorSize,
            child: const CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "Tunggu Sebentar...",
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }
}
