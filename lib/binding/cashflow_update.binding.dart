import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.category.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.update.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_account/tsx_account.controller.account.dart';

class CashFlowUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashFlowUpdateController>(() => CashFlowUpdateController());
    Get.lazyPut<CashflowCategoryController>(
      () => CashflowCategoryController(),
      fenix: true,
    );
    Get.lazyPut<TsxAccountController>(
      () => TsxAccountController(),
      fenix: true,
    );
  }
}
