import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class ProductData {
  Future<Map<String, dynamic>> fetchApiData({
    required int startPage,
    String? value,
  }) async {
    var products = <Product>[];
    var lastPage = 1;
    var response = await ApiService.get(
      '$url$productUrl',
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
      for (var item in data['product'] as List<dynamic>) {
        products.add(Product.fromJson(item));
      }
    }
    return {
      'last_page': lastPage,
      'data': products,
    };
  }

  Future<Product?> getSingleProduct(String id) async {
    var response = await ApiService.get(
      '$url$productUrl',
      queryParameters: getParamQuery(query: {'product_id': id}),
    );
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response)['data'];
      if (data is Map<String, dynamic>) {
        var product = Product.fromJson(data);
        return product;
      }
    }
    return null;
  }
}
