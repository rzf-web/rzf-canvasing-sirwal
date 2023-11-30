import 'package:rzf_canvasing_sirwal/enum/product_unit.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/interface/iname.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';

class ProductOnCart extends Product with IName {
  final TransactionType transaction;
  ProductUnitPrice priceType;
  ProductUnit? unit;
  double dscPercent;
  double dscNominal;
  int onCart;

  ProductOnCart({
    required super.id,
    required super.name,
    required super.type,
    required super.category,
    required super.supplier,
    required super.defaultUnit,
    required super.rack,
    required super.factory,
    required super.stock,
    required super.stockDisplay,
    required this.transaction,
    required this.onCart,
    this.priceType = ProductUnitPrice.retail,
    this.unit,
    this.dscNominal = 0,
    this.dscPercent = 0,
  });

  factory ProductOnCart.fromParent(Product data, TransactionType type) {
    return ProductOnCart(
      id: data.id,
      name: data.name,
      type: data.type,
      category: data.category,
      supplier: data.supplier,
      defaultUnit: data.defaultUnit,
      transaction: type,
      rack: data.rack,
      factory: data.factory,
      stock: data.stock,
      stockDisplay: data.stockDisplay,
      dscNominal: 0,
      onCart: 0,
    );
  }

  String getInitial() {
    return getInitialName(name);
  }

  Map<String, dynamic> toBuyJson() {
    return {
      'product_id': id,
      'product_name': name,
      'unit_name': unit!.unit,
      'qty': onCart ~/ unit!.isi!,
      'isi': unit!.isi!.toInt(),
      'retur': 0,
      'bonus': 0,
      'buy': unit!.buy,
      'discount': dscPercent,
      'hpp': 0,
      'ppn': 0,
    };
  }

  Map<String, dynamic> toSaleJson() {
    return {
      'product_id': id,
      'product_name': name,
      'unit_name': unit!.unit,
      'qty': onCart ~/ unit!.isi!.toInt(),
      'isi': unit!.isi!.toInt(),
      'retur': 0,
      'buy': unit!.buy,
      'sale': unit!.getPrice(priceType, transaction).toInt(),
      'discount': dscNominal,
    };
  }
}
