import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class Printer {
  static var devices = <BluetoothDevice>[];
  static var printer = BlueThermalPrinter.instance;
  static BluetoothDevice? _printerDevice;

  static Future<bool> getDevices({
    bool showMsg = true,
    bool showError = true,
  }) async {
    try {
      devices = await printer.getBondedDevices();
      if (devices.isEmpty) {
        if (showError) {
          await showDialogAction(
            ActionDialog.warning,
            "Tidak dapat menemukan device, silahkan check bluetooth anda",
          );
        }
        return false;
      } else {
        if (showMsg) {
          await showDialogAction(
            ActionDialog.succes,
            "${devices.length} device dalam sandingan",
          );
        }
        return true;
      }
    } catch (e) {
      if (showError) {
        showDialogAction(ActionDialog.warning, e.toString());
      }
      return false;
    }
  }

  static Future<bool> refreshMobile() async {
    var getDeviceSuccess = await getDevices(showError: true, showMsg: false);
    return getDeviceSuccess;
  }

  static refresh({bool showMsg = true}) async {
    try {
      await getDevices(showMsg: showMsg);
      if (_printerDevice != null) {
        var deviceName = _printerDevice?.name ?? "";
        var isConnected = await printer.isConnected;
        if (isConnected == true && deviceName != "") {
          showSnackbar("$deviceName Terhubung", AppTheme.primaryColor);
        }
      }
      return true;
    } catch (_) {
      showDialogAction(
        ActionDialog.warning,
        "Tidak dapat menemukan device, silahkan check bluetooth anda",
      );

      return false;
    }
  }

  static disconnect() async {
    if (_printerDevice != null) {
      await printer.disconnect();
      _printerDevice = null;
      showSnackbar("Perangkat terputus", const Color(0xFFFDBF44));
    } else {
      showDialogAction(
        ActionDialog.warning,
        "Anda tidak terhubung ke perangkat apapun",
      );
    }
  }

  static Future<BluetoothDevice?> connect(BluetoothDevice device) async {
    if (_printerDevice != null && _printerDevice!.address == device.address) {
      await printer.disconnect();
      await _connectToDevice(device);
      return _printerDevice;
    } else {
      await _connectToDevice(device);
      return _printerDevice;
    }
  }

  static _connectToDevice(BluetoothDevice device) async {
    try {
      _printerDevice = device;
      var isConnected = await printer.isConnected;
      if (isConnected!) {
        printer.disconnect();
      }
      waitingDialog();
      await printer.connect(_printerDevice!);
      Get.back();
      showDialogAction(
        ActionDialog.succes,
        "Terhubung dengan printer ${_printerDevice!.name}",
      );
    } catch (e) {
      Get.back();
      showDialogAction(
        ActionDialog.warning,
        "Tidak dapat terhubung dengan printer ${_printerDevice!.name}",
      );
      _printerDevice = null;
    }
  }
}
