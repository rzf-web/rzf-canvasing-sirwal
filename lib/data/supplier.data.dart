import 'package:rzf_canvasing_sirwal/model/supplier.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class SupplierData {
  Future<Map<String, dynamic>> fetchApiData({
    required int startPage,
    String? value,
  }) async {
    var suppliers = <Supplier>[];
    var lastPage = 1;

    var response = await ApiService.get(
      '$url$supplierUrl',
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
      for (var item in data['supplier']) {
        suppliers.add(Supplier.fromJson(item));
      }
    }
    return {
      'last_page': lastPage,
      'data': suppliers,
    };
  }

  // Future<List<Supplier>> getAPIInsertDB() async {
  //   var suppliers = await fetchApiData();
  //   await SqlService.deleteData(SqlHelper.tbSupplier);
  //   if (suppliers.isNotEmpty) {
  //     for (var item in suppliers) {
  //       await SqlService.addData(
  //         SqlHelper.tbSupplier,
  //         item.toJson(false, isToDB: true),
  //       );
  //     }
  //   }
  //   return suppliers;
  // }

  // Future<List<Supplier>> getDataFromDB() async {
  //   var suppliers = <Supplier>[];
  //   var data = await SqlService.getData(SqlHelper.tbSupplier);
  //   for (var item in data) {
  //     suppliers.add(Supplier.fromJson(item));
  //   }
  //   return suppliers;
  // }
}
