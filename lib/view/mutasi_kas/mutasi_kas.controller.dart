import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/mutasi_kas.data.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/mutasi_kas.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';

class MutasiKasController extends GetxController {
  var startDate = DateTime.now();
  var endDate = DateTime.now();
  var isLoading = false.obs;
  var mutations = <MutasiKas>[].obs;

  getMutations() async {
    isLoading.value = true;
    mutations.value = await MutasiKasData().fetchApiData(
      startDate: dateFormatAPI(startDate),
      endDate: dateFormatAPI(endDate),
    );
    isLoading.value = false;
  }

  pickDate(start, end) async {
    startDate = start;
    endDate = end;
    await getMutations();
  }

  mutasiKasUpdatePage({MutasiKas? data}) async {
    var updated = await Get.toNamed(Routes.mutasiKasUpdate, arguments: data);
    if (updated != null) {
      getMutations();
    }
  }

  MutasiKas getLastData() {
    return mutations.last;
  }

  @override
  Future<void> onInit() async {
    getMutations();
    super.onInit();
  }
}
