import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/mutasi_kas/mutasi_kas.controller.update.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_account/tsx_account.controller.account.dart';

class MutasiKasUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MutasiKasUpdateController>(() => MutasiKasUpdateController());
    Get.lazyPut<TsxAccountController>(
      () => TsxAccountController(),
      fenix: true,
    );
  }
}
