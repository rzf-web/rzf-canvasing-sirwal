import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/home/home.controller.dart';
import 'package:rzf_canvasing_sirwal/view/menu/menu.controller.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/navigation.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BuyController>(
      () => BuyController(isFromHome: true),
      fenix: true,
    );
    Get.lazyPut<SaleController>(
      () => SaleController(isFromHome: true),
      fenix: true,
    );
    Get.lazyPut<AppMenuController>(() => AppMenuController());
  }
}
