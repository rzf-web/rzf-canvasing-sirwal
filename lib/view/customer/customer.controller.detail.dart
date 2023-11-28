import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';

class CustomerDetailController extends GetxController {
  final data = Get.arguments as Customer;

  onEditData() {
    Get.toNamed(Routes.customerUpdate, arguments: data);
  }
}
