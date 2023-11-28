import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.controller.update.dart';

class CustomerUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerUpdateController>(() => CustomerUpdateController());
  }
}
