import 'package:rzf_canvasing_sirwal/model/buy.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class BuyData {
  Future<Map<String, dynamic>> fetchApiData({
    required String supplier,
    required String startDate,
    required String endDate,
    required int startPage,
  }) async {
    var buys = <Buy>[];
    var lastPage = 0;
    var response = await ApiService.get(
      url + buyUrl,
      queryParameters: getParamQuery(
        query: {
          'keyword': supplier,
          'start_date': startDate,
          'end_date': endDate,
          'start_page': startPage,
          'limit_page': 50,
        },
      ),
    );
    var succes = await manageResponse(response);
    if (succes) {
      var data = getDataResponse(response)['data'];
      lastPage = data['last_page'];
      for (var item in data['buy']) {
        buys.add(Buy.fromJson(item));
      }
    }
    return {
      'last_page': lastPage,
      'data': buys,
    };
  }
}
