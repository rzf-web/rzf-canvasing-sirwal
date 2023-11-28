import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/mutasi_kas/mutasi_kas.controller.dart';

class MutasiKasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MutasiKasController>(() => MutasiKasController());
  }
}
