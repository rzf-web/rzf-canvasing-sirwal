import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppCashflowReportPriode extends StatefulWidget {
  final Function(DateTime, DateTime) onChanged;
  const AppCashflowReportPriode({super.key, required this.onChanged});

  @override
  State<AppCashflowReportPriode> createState() =>
      _AppCashflowReportPriodeState();
}

class _AppCashflowReportPriodeState extends State<AppCashflowReportPriode> {
  var periodic = [
    'Bulan Ini',
    'Bulan Lalu',
    'Custom',
  ];
  var active = 'Bulan Ini'.obs;
  bool isFirst(String element) => element == periodic.first;
  bool isLast(String element) => element == periodic.last;
  bool isMiddle(String element) => element == 'Bulan Lalu';

  onChanged(String e) async {
    active.value = e;
    var dateNow = DateTime.now();
    var firstDate = DateTime(dateNow.year, dateNow.month, 1);
    var endDate = DateTime(dateNow.year, dateNow.month + 1, 0);
    switch (active.value) {
      case 'Bulan Ini':
        widget.onChanged(firstDate, endDate);
        break;
      case 'Bulan Lalu':
        firstDate = DateTime(dateNow.year, dateNow.month - 1, 1);
        endDate = DateTime(dateNow.year, dateNow.month, 0);
        widget.onChanged(firstDate, endDate);
        break;
      case 'Custom':
        await showCustomeDateRangePicker((v1, v2) {
          firstDate = v1;
          endDate = v2;
          widget.onChanged(firstDate, endDate);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...periodic.map(
          (e) => Expanded(
            child: GestureDetector(
              onTap: () => onChanged(e),
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(
                        color: AppTheme.primaryColor,
                        width: isMiddle(e) ? 0 : 1,
                      ),
                      horizontal: const BorderSide(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    borderRadius: BorderRadius.horizontal(
                      left: isFirst(e) ? const Radius.circular(3) : Radius.zero,
                      right: isLast(e) ? const Radius.circular(3) : Radius.zero,
                    ),
                    color: active.value == e
                        ? AppTheme.primaryColor
                        : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      e,
                      style: TextStyle(
                        fontSize: 12,
                        color: active.value == e
                            ? Colors.white
                            : AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
