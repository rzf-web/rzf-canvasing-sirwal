import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/scanner/scanner.controller.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerController>(() => ScannerController());
  }
}
