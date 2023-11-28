import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.controller.detail.dart';

class CustomerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDetailController>(() => CustomerDetailController());
  }
}
