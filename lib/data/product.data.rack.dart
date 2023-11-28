import 'package:rzf_canvasing_sirwal/abstract/fetch_api_data.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class ProductRacksData extends FetchApiData {
  @override
  Future<List<String>> fetchApiData() async {
    var racks = <String>[];
    var response = await ApiService.get(
      '$url$rackUrl',
      queryParameters: getParamQuery(),
    );
    var succes = await manageResponse(response);
    if (succes) {
      var data = getDataResponse(response)['data'];
      for (var item in data as List<dynamic>) {
        racks.add(item['rak']);
      }
    }
    return racks;
  }
}
