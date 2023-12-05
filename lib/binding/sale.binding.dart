import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.controller.dart';

class SaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleController>(() => SaleController(), fenix: true);
  }
}
