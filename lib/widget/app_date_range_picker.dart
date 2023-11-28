import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/global_style.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppDateRangePicker extends StatelessWidget {
  final Function(DateTime)? onDateSingleSubmit;
  final Function(DateTime, DateTime)? onDateRangeSubmit;
  final DateRangePickerSelectionMode selectionMode;
  const AppDateRangePicker({
    super.key,
    this.onDateRangeSubmit,
    this.onDateSingleSubmit,
    this.selectionMode = DateRangePickerSelectionMode.range,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context) * .6,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: SfDateRangePicker(
              headerHeight: 80,
              viewSpacing: 12,
              navigationDirection: DateRangePickerNavigationDirection.vertical,
              headerStyle: const DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
              ),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(fontSize: 12),
                ),
              ),
              selectionMode: selectionMode,
              view: DateRangePickerView.month,
              allowViewNavigation: true,
              showActionButtons: true,
              onCancel: Get.back,
              onSubmit: (value) {
                if (value != null) {
                  if (selectionMode == DateRangePickerSelectionMode.range) {
                    var date = value as PickerDateRange;
                    if (date.startDate != null && date.endDate != null) {
                      onDateRangeSubmit!(date.startDate!, date.endDate!);
                      Get.back();
                    }
                  } else {
                    onDateSingleSubmit!(value as DateTime);
                    Get.back();
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
