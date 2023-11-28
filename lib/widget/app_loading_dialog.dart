import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppLoadingDialog extends StatelessWidget {
  final String? message;
  const AppLoadingDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Column(
        children: [
          const SizedBox(height: 30),
          const CircularProgressIndicator(color: AppTheme.primaryColor),
          const SizedBox(height: 40),
          Text(
            message ?? "Tunggu Sebentar....",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
