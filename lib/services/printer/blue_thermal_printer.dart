import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class Printer {
  static var devices = <BluetoothDevice>[];
  static var printer = BlueThermalPrinter.instance;
  static BluetoothDevice? _printerDevice;
  static BluetoothDevice? get printerConnected => _printerDevice;
  static const int _size = 0;

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

  static printInvoice(Map<String, dynamic> data) async {
    var invoices = data['data'] as List<dynamic>;
    var invoice = invoices[0];
    var faktur = invoice['faktur'];
    var cashier = invoice['kasir'];
    var date = DateTime.tryParse(invoice['tanggal']);
    var dateFormat = dateFormatUI(date!, format: "EEEE, dd MMMM yyyy");
    var customer = invoice['pelanggan'];
    var customerType = invoice['jenis'];
    var address = invoice['alamat'];
    var subTotal = double.tryParse(invoice['total']) ?? 0.0;
    var pay = double.tryParse(invoice['bayar']) ?? 0.0;
    var kembali = double.tryParse(invoice['kembali']) ?? 0.0;
    var hemat = 0.0;
    var hematPercent = 0.0;
    var totalQty = 0.0;

    await _printImage();
    printer.printCustom("Pusat Busana Muslim Terlengkap", _size, 1);
    printer.printCustom(
      "${GlobalVar.profile!.address} ${GlobalVar.profile!.phone}",
      _size,
      1,
    );
    printer.printCustom("--------------------------------", _size, 1);
    printer.printCustom("Kasir : $cashier | $faktur", _size, 0);
    printer.printCustom(dateFormat, _size, 0);
    printer.printCustom("Kepada Yth, $customer", _size, 0);
    printer.printCustom(customerType, _size, 0);
    printer.printCustom("$address", _size, 0);
    printer.printCustom("--------------------------------", _size, 1);
    var no = 1;
    for (var item in invoices) {
      var name = item['nama'];
      var qty = double.parse(item['qty']);
      var unit = item['satuan'];
      var price = double.parse(item['harga']);
      var discount = double.parse(item['diskon']);
      var normalPrice = double.tryParse(item['harganormal']) ?? 0;
      var difference = normalPrice - price;
      var percentase = (difference / normalPrice) * 100;

      hemat += (normalPrice - price) * qty;
      totalQty += qty;
      printer.printCustom("$no. $name", _size, 0);
      printer.printLeftRight(
        "${doubleFormatter(qty)} $unit @${numberFormatter(price)}",
        numberFormatter(price * qty),
        _size,
      );
      if (price != normalPrice) {
        printer.printLeftRight(
          "${numberFormatter(normalPrice)} (${percentase.round()}%)",
          "- ${numberFormatter(discount * qty)}",
          _size,
        );
      }
      printer.printNewLine();
      no++;
    }
    hematPercent = (hemat / subTotal) * 100;
    printer.printCustom("--------------------------------", _size, 1);
    printer.printLeftRight('Jumlah Qty', doubleFormatter(totalQty), _size);
    printer.printLeftRight(
      'Hemat (${hematPercent.round()}%)',
      "-${numberFormatter(hemat)}",
      _size,
    );
    printer.printLeftRight('Subtotal', numberFormatter(subTotal), _size);
    printer.printLeftRight('Bayar', numberFormatter(pay), _size);
    printer.printLeftRight('Kembali', numberFormatter(kembali), _size);
    printer.printCustom("--------------------------------", _size, 1);
    printer.printCustom(
      "Tunjukan nota ini jika ingin\nmelakukan penukaran barang*",
      _size,
      1,
    );
    printer.printNewLine();
    printer.printCustom(
      "JAZAKUMULLAH KHAIRAN ATAS\nKUNJUNGAN ANDA",
      _size,
      1,
    );
    printer.printNewLine();
    printer.printCustom(
      "CS 1: 0813-3135-5365",
      _size,
      1,
    );
    printer.printCustom(
      "CS 2: 0895-0531-9455",
      _size,
      1,
    );
    printer.paperCut();
  }

  static _printImage() async {
    ByteData bytesAsset = await rootBundle.load(invoiceImage);
    Uint8List imageBytesFromAsset = bytesAsset.buffer
        .asUint8List(bytesAsset.offsetInBytes, bytesAsset.lengthInBytes);
    printer.printImageBytes(imageBytesFromAsset);
  }
}
