import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.controller.add.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.controller.dart';

class SaleAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleAddController>(() => SaleAddController(), fenix: true);
    Get.lazyPut<TsxProductListController>(
      () => TsxProductListController(TransactionType.sale),
    );
  }
}
