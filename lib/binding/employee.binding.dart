import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/employee/employee.controller.dart';

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
  }
}
