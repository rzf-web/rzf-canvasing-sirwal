import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppDetailMapView extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  const AppDetailMapView({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Map",
            style: TextStyle(color: AppTheme.capColor),
          ),
        ),
        Container(
          height: 178,
          width: double.infinity,
          margin: margin,
          decoration: BoxDecoration(
            color: AppTheme.secBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(child: Text("Lokasi Pelanggan")),
        ),
      ],
    );
  }
}
