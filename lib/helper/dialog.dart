import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rzf_canvasing_sirwal/widget/app_btm_modal_camera_source.dart';
import 'package:rzf_canvasing_sirwal/widget/app_date_range_picker.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

waitingDialog({String? message}) {
  return Get.dialog(
    AppLoadingDialog(message: message),
    barrierDismissible: false,
  );
}

showDialogCustom(Widget content) async {
  await Get.dialog(
    transitionCurve: Curves.easeIn,
    AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      actionsPadding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 18.0),
      content: content,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  );
}

showDialogAction(
  ActionDialog actionDialog,
  String message, {
  Function()? onConfrimYes,
}) async {
  await showDialogCustom(
    AppDialogAction(
      actionDialog: actionDialog,
      message: message,
      onConfrimYes: onConfrimYes,
    ),
  );
}

showBottomBar(Widget content) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context!,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    builder: (context) => SafeArea(child: content),
  );
}

showSnackbar(String message, Color color) {
  Get.rawSnackbar(
    borderRadius: 80,
    maxWidth: double.infinity,
    snackPosition: SnackPosition.TOP,
    borderColor: color,
    backgroundColor: color.withOpacity(.1),
    duration: const Duration(milliseconds: 1000),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
    messageText: Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, color: color),
      ),
    ),
  );
}

showCustomeDateRangePicker(Function(DateTime, DateTime) onApplyClick) async {
  await showDialogCustom(AppDateRangePicker(onDateRangeSubmit: onApplyClick));
}

showCustomDatePicker(Function(DateTime) onApplyClick) async {
  await showDialogCustom(
    AppDateRangePicker(
      onDateSingleSubmit: onApplyClick,
      selectionMode: DateRangePickerSelectionMode.single,
    ),
  );
}

Future<ImageSource?> showImagePicker(BuildContext context) async {
  ImageSource? source;
  await showModalBottomSheet(
    context: context,
    builder: (context) => AppBtmModalCameraSource(onTap: (v) => source = v),
  );
  return source;
}
