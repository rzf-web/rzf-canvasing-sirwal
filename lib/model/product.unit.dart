import 'package:rzf_canvasing_sirwal/enum/product_unit.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';

class ProductUnit {
  final String unit;
  final double? isi;
  final double buy;
  final double retail;
  final double partai;
  final double cabang;

  ProductUnit({
    required this.unit,
    required this.isi,
    required this.buy,
    required this.retail,
    required this.partai,
    required this.cabang,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) {
    return ProductUnit(
      unit: json['unit_name'],
      isi: FuncHelper().jsonStringToDouble(json['isi'] ?? 1),
      buy: FuncHelper().jsonStringToDouble(json['buy']),
      retail: FuncHelper().jsonStringToDouble(json['retail']),
      partai: FuncHelper().jsonStringToDouble(json['partai']),
      cabang: FuncHelper().jsonStringToDouble(json['cabang']),
    );
  }

  double getPrice(ProductUnitPrice v, TransactionType transaction) {
    var sale = _getSalePrice(v);
    return transaction.isBuy ? buy : sale;
  }

  double _getSalePrice(ProductUnitPrice v) {
    switch (v) {
      case ProductUnitPrice.partai:
        return partai;
      case ProductUnitPrice.cabang:
        return cabang;
      default:
        return retail;
    }
  }
}
