import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/signin/signin.controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
