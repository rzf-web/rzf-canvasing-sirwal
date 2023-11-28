import 'package:rzf_canvasing_sirwal/abstract/fetch_api_data.dart';
import 'package:rzf_canvasing_sirwal/data/data_dummy.dart';
import 'package:rzf_canvasing_sirwal/model/order.dart';

class OrderData extends FetchApiData {
  @override
  Future<List<Order>> fetchApiData() async {
    var data = <Order>[];
    for (var item in saleList) {
      data.add(Order.fromJson(item));
    }
    return data;
  }
}
