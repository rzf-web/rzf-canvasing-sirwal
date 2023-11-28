import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';

class ScannerController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  Future<void> onFlashTap() async {
    await controller!.toggleFlash();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      final player = AudioPlayer();
      await player.play(AssetSource(scanSound), volume: 1.0);
      await controller.pauseCamera();
      await Future.delayed(const Duration(milliseconds: 1050));
      Get.back(result: result!);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
