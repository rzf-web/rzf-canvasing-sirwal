import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Sale with IName {
  final String id;
  final String name;
  final String date;
  final String address;
  final String total;

  Sale({
    required this.id,
    required this.name,
    required this.date,
    required this.address,
    required this.total,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['sale_id'],
      date: json['sale_date'],
      name: json['customer_name'],
      address: json['address'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toMapList() {
    return {
      'id': id,
      'initial': getInitial(),
      'name': name,
      'date': date,
      'address': address,
      'total': total,
    };
  }

  String getInitial() {
    return getInitialName(name);
  }
}
