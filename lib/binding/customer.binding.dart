import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.controller.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}
