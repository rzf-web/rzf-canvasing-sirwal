import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.dart';

class CashFlowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashFlowController>(() => CashFlowController(), fenix: true);
  }
}
