import 'package:rzf_canvasing_sirwal/enum/product_unit.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';

class ProductUnit {
  final String unit;
  final double? isi;
  final double buy;
  final double retail;
  final double member;
  final double grosir3;
  final double grosir6;
  final double grosir12;

  ProductUnit({
    required this.unit,
    required this.isi,
    required this.buy,
    required this.retail,
    required this.member,
    required this.grosir3,
    required this.grosir6,
    required this.grosir12,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) {
    return ProductUnit(
      unit: json['unit_name'],
      isi: FuncHelper().jsonStringToDouble(json['isi'] ?? 1),
      buy: FuncHelper().jsonStringToDouble(json['buy']),
      retail: FuncHelper().jsonStringToDouble(json['retail']),
      member: FuncHelper().jsonStringToDouble(json['member']),
      grosir3: FuncHelper().jsonStringToDouble(json['grosir3']),
      grosir6: FuncHelper().jsonStringToDouble(json['grosir6']),
      grosir12: FuncHelper().jsonStringToDouble(json['grosir12']),
    );
  }

  double getPrice(ProductUnitPrice v, TransactionType transaction) {
    var sale = _getSalePrice(v);
    return transaction.isBuy ? buy : sale;
  }

  double _getSalePrice(ProductUnitPrice v) {
    switch (v) {
      case ProductUnitPrice.grosir1:
        return member;
      case ProductUnitPrice.grosir2:
        return grosir3;
      default:
        return retail;
    }
  }
}
