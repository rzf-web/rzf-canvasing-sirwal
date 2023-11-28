import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppDataNotFound extends StatelessWidget {
  final double? height;
  final double? width;
  final String? message;
  const AppDataNotFound({super.key, this.height, this.width, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SvgPicture.asset(
                ilusNoData,
                height: height ?? 180,
                width: width ?? 236,
              ),
            ),
            Text(
              message ?? "Data tidak ditemukan",
              style: const TextStyle(fontSize: 16, color: AppTheme.titleColor),
            ),
          ],
        ),
      ),
    );
  }
}
