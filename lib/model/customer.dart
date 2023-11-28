import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Customer with IName {
  final String? id;
  final String name;
  final String phone;
  final String noPolice;
  final String merk;
  final String model;
  final String alamat;

  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.noPolice,
    required this.merk,
    required this.model,
    required this.alamat,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['customer_id'],
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      noPolice: json['noPolisi'] ?? "",
      merk: json['merk'] ?? "",
      model: json['model'] ?? "",
      alamat: json['address'] ?? "",
    );
  }

  String getInitial() {
    return super.getInitialName(name);
  }
}
