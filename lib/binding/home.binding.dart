import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/home/home.controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
