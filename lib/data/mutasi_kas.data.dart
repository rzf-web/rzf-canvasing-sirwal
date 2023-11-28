import 'package:rzf_canvasing_sirwal/model/mutasi_kas.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class MutasiKasData {
  Future<List<MutasiKas>> fetchApiData({
    required String startDate,
    required String endDate,
  }) async {
    var mutations = <MutasiKas>[];
    var response = await ApiService.get(
      "$url$mutasiCash",
      queryParameters: getParamQuery(
        query: {'start_date': startDate, 'end_date': endDate},
      ),
    );
    var succes = await manageResponse(response);
    if (succes) {
      var data = getDataResponse(response)['data'];
      for (var item in data) {
        mutations.add(MutasiKas.fromJson(item));
      }
    }
    return mutations;
  }
}
