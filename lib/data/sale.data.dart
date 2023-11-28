import 'package:rzf_canvasing_sirwal/model/sale.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class SaleData {
  Future<Map<String, dynamic>> fetchApiData({
    required String supplier,
    required String startDate,
    required String endDate,
    required int startPage,
  }) async {
    var sales = <Sale>[];
    var lastPage = 0;
    var response = await ApiService.get(
      url + saleUrl,
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
      for (var item in data['sale']) {
        sales.add(Sale.fromJson(item));
      }
    }
    return {
      'last_page': lastPage,
      'data': sales,
    };
  }
}
