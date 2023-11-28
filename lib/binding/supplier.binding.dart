import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.controller.dart';

class SupplierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierController>(() => SupplierController());
  }
}
