import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/model/cashflow.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class CashFlowData {
  Future<List<CashFlowUI>> fetchApiData({
    required CashFlowType type,
    required String startDate,
    required String endDate,
  }) async {
    var data = <CashFlowUI>[];
    var response = await ApiService.get(
      "$url$cashFlowUrl",
      queryParameters: getParamQuery(
        query: {
          'type': type.nameLocale,
          'start_date': startDate,
          'end_date': endDate,
          'group_key': 'tanggal',
        },
      ),
    );

    var succes = await manageResponse(response);
    if (succes) {
      var dataResponse = getDataResponse(response)['data'];
      for (var item in dataResponse) {
        data.add(CashFlowUI.fromJson(item));
      }
    }
    return data;
  }

  Future<Map<String, dynamic>> fetchApiDataReport({
    required String startDate,
    required String endDate,
  }) async {
    dynamic summary;
    dynamic list1;
    dynamic list2;
    var response1 = await ApiService.get(
      "$url$cashFlowUrl$reportCashFlowUrl",
      queryParameters: getParamQuery(
        query: {
          'type': "Pemasukan",
          'start_date': startDate,
          'end_date': endDate,
        },
      ),
    );
    var response2 = await ApiService.get(
      "$url$cashFlowUrl$reportCashFlowUrl",
      queryParameters: getParamQuery(
        query: {
          'type': CashFlowType.cashout.nameLocale,
          'start_date': startDate,
          'end_date': endDate,
        },
      ),
    );
    var succes1 = await manageResponse(response1);
    var succes2 = await manageResponse(response2);
    if (succes1 && succes2) {
      var data1 = getDataResponse(response1)['data'];
      var data2 = getDataResponse(response2)['data'];
      summary = data1['summary'][0];

      list1 = data1['list'];
      list2 = data2['list'];
    }
    return {
      'summary': summary,
      'cashIn': list1,
      'cashOut': list2,
    };
  }

  Future<List<String>> getCategories(CashFlowType type) async {
    var categories = <String>[];
    var response = await ApiService.get(
      "$url$cashFlowUrl$categoryCashFlowUrl",
      queryParameters: getParamQuery(
        query: {'type': type.nameLocale},
      ),
    );
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response)['data'];
      for (var item in data) {
        categories.add(item['category']);
      }
    }
    return categories;
  }
}
