import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_pop_up_menu_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppDateReport extends StatefulWidget {
  final Function(DateTime, DateTime) onSubmit;
  const AppDateReport({super.key, required this.onSubmit});

  @override
  State<AppDateReport> createState() => _AppDateReportState();
}

class _AppDateReportState extends State<AppDateReport> {
  pickDateRange() async {
    await showCustomeDateRangePicker((v1, v2) async {
      widget.onSubmit(v1, v2);
    });
  }

  pickSingleDate() async {
    await showCustomDatePicker((date) {
      widget.onSubmit(date, date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPopUpMenuBtn(
      menu: [
        PopupMenuItem(onTap: pickDateRange, child: const Text("Periode")),
        PopupMenuItem(onTap: pickSingleDate, child: const Text("Tanggal")),
      ],
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: const Stack(
          children: [
            Center(child: AppSvgIcon(svg: svgRecap, size: 20)),
          ],
        ),
      ),
    );
  }
}
