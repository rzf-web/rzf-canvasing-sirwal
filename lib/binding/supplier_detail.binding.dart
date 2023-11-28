import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.controller.detail.dart';

class SupplierDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierDetailController>(() => SupplierDetailController());
  }
}
