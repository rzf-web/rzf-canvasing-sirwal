import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class CustomerData {
  Future<Map<String, dynamic>> fetchApiData({
    required int startPage,
    String? value,
  }) async {
    var customers = <Customer>[];
    var lastPage = 1;

    var response = await ApiService.get(
      '$url$customerUrl',
      queryParameters: getParamQuery(
        query: {
          'start_page': startPage,
          'limit_page': 50,
          'keyword': value ?? '',
        },
      ),
    );
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response)['data'];
      lastPage = data['last_page'];
      for (var item in data['customer']) {
        customers.add(Customer.fromJson(item));
      }
    }
    return {
      'last_page': lastPage,
      'data': customers,
    };
  }
}
