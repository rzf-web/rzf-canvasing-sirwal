import 'package:rzf_canvasing_sirwal/abstract/fetch_api_data.dart';

class ProvinceData extends FetchApiData {
  final int id;
  final String name;

  ProvinceData({required this.id, required this.name});

  factory ProvinceData.fromJson(Map<String, dynamic> json) {
    return ProvinceData(id: json['id'], name: json['name']);
  }

  @override
  Future<List<ProvinceData>> fetchApiData() async {
    return <ProvinceData>[];
  }
}
