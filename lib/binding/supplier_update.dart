import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.controller.update.dart';

class SupplierUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierUpdateController>(() => SupplierUpdateController());
  }
}
