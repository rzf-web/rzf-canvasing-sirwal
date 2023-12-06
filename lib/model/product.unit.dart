import 'package:rzf_canvasing_sirwal/enum/product_price_type.enum.dart';
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
  final double agen;

  ProductUnit({
    required this.unit,
    required this.isi,
    required this.buy,
    required this.retail,
    required this.member,
    required this.grosir3,
    required this.grosir6,
    required this.grosir12,
    required this.agen,
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
      agen: FuncHelper().jsonStringToDouble(json['agen']),
    );
  }

  double getPrice(
    TransactionType transaction, {
    ProductPriceType priceType = ProductPriceType.retail,
  }) {
    var sale = _getSalePrice(priceType);
    return transaction.isBuy ? buy : sale;
  }

  double _getSalePrice(ProductPriceType type) {
    switch (type) {
      case ProductPriceType.retail:
        return retail;
      case ProductPriceType.member:
        return member;
      case ProductPriceType.grosir3:
        return grosir3;
      case ProductPriceType.grosir6:
        return grosir6;
      case ProductPriceType.grosir12:
        return grosir12;
      case ProductPriceType.agen:
        return agen;
    }
  }
}
