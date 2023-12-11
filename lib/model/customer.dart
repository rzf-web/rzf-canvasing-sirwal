import 'package:rzf_canvasing_sirwal/enum/customer_type.dart';
import 'package:rzf_canvasing_sirwal/enum/product_price_type.enum.dart';
import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Customer with IName {
  final String? id;
  final String name;
  final String phone;
  final String noPolice;
  final String merk;
  final String model;
  final String alamat;
  final CustomerType type;
  final Map<String, ProductPriceType> levels;

  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.noPolice,
    required this.merk,
    required this.model,
    required this.alamat,
    required this.type,
    required this.levels,
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
      type: CustomerType.fromJson(json['member']),
      levels: _generateLevels(json['level']),
    );
  }

  static Map<String, ProductPriceType> _generateLevels(dynamic json) {
    var data = <String, ProductPriceType>{};
    var levels = json as Map<String, dynamic>;
    for (var key in levels.keys) {
      if (key != 'jenis') {
        data[key] = ProductPriceTypeExtension.generateJson(levels[key]);
      }
    }

    return data;
  }

  String getInitial() {
    return super.getInitialName(name);
  }
}
