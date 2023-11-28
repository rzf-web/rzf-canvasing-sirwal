import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppUnitColHeader extends StatefulWidget {
  final Function(String) onChanged;
  const AppUnitColHeader({
    super.key,
    required this.onChanged,
  });

  @override
  State<AppUnitColHeader> createState() => _AppUnitColHeaderState();
}

class _AppUnitColHeaderState extends State<AppUnitColHeader> {
  var defaultPrice = 'Harga Retail'.obs;
  var price = [
    'Harga Retail',
    'Harga Partai',
    'Harga Cabang',
  ];

  var textStyle = const TextStyle(
    fontSize: 14,
    color: AppTheme.titleColor,
    fontFamily: AppTheme.fontFamily,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEF2F8), width: 4)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text("Satuan", style: textStyle),
          ),
          Expanded(
            flex: 1,
            child: Text("Jumlah", style: textStyle),
          ),
          Expanded(
            flex: 2,
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  elevation: 1,
                  isDense: true,
                  isExpanded: true,
                  padding: const EdgeInsets.only(left: 4),
                  value: defaultPrice.value,
                  items: price.map((e) => buildMenuItem(e)).toList(),
                  icon: Center(
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: const AppSvgIcon(
                        svg: svgChevronRight,
                        size: 24,
                        color: AppTheme.capColor,
                      ),
                    ),
                  ),
                  onChanged: (v) {
                    defaultPrice.value = v!;
                    widget.onChanged(defaultPrice.value);
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 10,
            width: 42,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item, style: textStyle));
}
