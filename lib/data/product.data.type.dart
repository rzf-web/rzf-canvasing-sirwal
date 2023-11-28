import 'package:rzf_canvasing_sirwal/abstract/fetch_api_data.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class ProductTypeData extends FetchApiData {
  @override
  Future<List<String>> fetchApiData() async {
    var types = <String>[];
    var response = await ApiService.get(
      '$url$productTypeUrl',
      queryParameters: getParamQuery(),
    );
    var succes = await manageResponse(response);
    if (succes) {
      var data = getDataResponse(response)['data'];
      for (var item in data as List<dynamic>) {
        types.add(item['type_name']);
      }
    }
    return types;
  }
}
