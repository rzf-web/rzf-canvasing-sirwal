import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/payment/payment.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_account/tsx_account.controller.account.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
    Get.lazyPut<TsxAccountController>(() => TsxAccountController(),
        fenix: true);
  }
}
