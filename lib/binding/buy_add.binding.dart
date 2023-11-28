import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.controller.add.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.controller.dart';

class BuyAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyAddController>(() => BuyAddController(), fenix: true);
    Get.lazyPut<TsxProductListController>(
      () => TsxProductListController(TransactionType.buy),
    );
  }
}
