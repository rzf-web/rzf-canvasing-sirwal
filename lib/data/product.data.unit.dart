import 'package:rzf_canvasing_sirwal/abstract/fetch_api_data.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class ProductUnitData extends FetchApiData {
  @override
  Future<List<String>> fetchApiData() async {
    var units = <String>[];
    var response = await ApiService.get(
      '$url$unitUrl',
      queryParameters: getParamQuery(),
    );
    var succes = await manageResponse(response);
    if (succes) {
      var data = getDataResponse(response)['data'];
      for (var item in data as List<dynamic>) {
        units.add(item['unit_name']);
      }
    }
    return units;
  }

  Future<List<ProductUnit>> getProductUnit(String barcode) async {
    var units = <ProductUnit>[];
    var response = await ApiService.get(
      "$url$multisatUrl",
      queryParameters: getParamQuery(query: {
        'barcode': barcode,
        'cabang_id': GlobalVar.employee!.idCabang,
      }),
    );
    var succes = await manageResponse(response);
    if (succes) {
      var data = getDataResponse(response)['data']['multi_unit'];
      for (var item in data as List<dynamic>) {
        units.add(ProductUnit.fromJson(item));
      }
    }
    return units;
  }
}
