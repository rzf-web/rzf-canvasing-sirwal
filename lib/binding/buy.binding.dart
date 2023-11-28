import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.controller.dart';

class BuyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyController>(() => BuyController());
  }
}
