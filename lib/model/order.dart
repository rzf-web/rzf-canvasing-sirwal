import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Order with IName {
  final int? id;
  final String name;
  final String address;
  final double total;

  Order({
    required this.id,
    required this.name,
    required this.address,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toMapList() {
    return {
      'id': id,
      'initial': getInitial(),
      'name': name,
      'address': address,
      'total': total,
    };
  }

  String getInitial() {
    return getInitialName(name);
  }
}
