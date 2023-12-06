import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/interface/iname.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';

class ProductOnCart extends Product with IName {
  final TransactionType transaction;
  ProductUnit? unit;
  int pointsEarned;
  double dscPercent;
  double dscNominal;
  int onCart;

  ProductOnCart({
    required super.id,
    required super.barcode,
    required super.name,
    required super.panjang,
    required super.productSize,
    required super.variant,
    required super.type,
    required super.category,
    required super.supplier,
    required super.defaultUnit,
    required super.rack,
    required super.factory,
    required super.stock,
    required super.nominalPoint,
    required super.pointType,
    required super.stockDisplay,
    required this.transaction,
    required this.onCart,
    this.unit,
    this.pointsEarned = 0,
    this.dscNominal = 0,
    this.dscPercent = 0,
  });

  factory ProductOnCart.fromParent(Product data, TransactionType type) {
    return ProductOnCart(
      id: data.id,
      barcode: data.barcode,
      name: data.name,
      panjang: data.panjang,
      productSize: data.productSize,
      variant: data.variant,
      type: data.type,
      category: data.category,
      supplier: data.supplier,
      defaultUnit: data.defaultUnit,
      transaction: type,
      rack: data.rack,
      factory: data.factory,
      stock: data.stock,
      stockDisplay: data.stockDisplay,
      nominalPoint: data.nominalPoint,
      pointType: data.pointType,
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
      'sale': unit!.getPrice(transaction).toInt(),
      'discount': dscNominal,
    };
  }

  List<ProductOnCart> getSimilarProductOnCart(List<ProductOnCart> products) {
    var similarProducts = products.where(
      (x) => x.id == id && x.barcode != barcode,
    );
    return similarProducts.toList();
  }
}
