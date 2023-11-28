import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/view/scanner/scanner.controller.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class ScannerPage extends GetView<ScannerController> {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: "Scan Produk",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: AppSvgIconBtn(
              svg: svgFlashLight,
              onTap: controller.onFlashTap,
            ),
          ),
        ],
      ),
      body: QRView(
        key: controller.qrKey,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 20,
          borderLength: 30,
          borderWidth: 8,
          cutOutSize: 200,
        ),
        onQRViewCreated: controller.onQRViewCreated,
      ),
    );
  }
}
