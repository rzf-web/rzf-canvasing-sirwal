import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Buy with IName {
  final String? id;
  final String name;
  final String date;
  final String address;
  final String total;

  Buy({
    required this.id,
    required this.name,
    required this.date,
    required this.address,
    required this.total,
  });

  factory Buy.fromJson(Map<String, dynamic> json) {
    return Buy(
      id: json['buy_id'],
      date: json['buy_date'],
      name: json['supplier_name'],
      address: json['address'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toMapList() {
    return {
      'id': id,
      'initial': getInitial(),
      'date': date,
      'name': name,
      'address': address,
      'total': total,
    };
  }

  String getInitial() {
    return getInitialName(name);
  }
}
