import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/enum/product_point_type.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/interface/iname.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';

class Product with IName {
  final String? id;
  final String? barcode;
  final String name;
  final String categoryAge;
  final String panjang;
  final String productSize;
  final String variant;
  final String type;
  final String category;
  final String supplier;
  final String rack;
  final String factory;
  final double stock;
  final double stockDisplay;
  final double nominalPoint;
  final ProductPointType pointType;
  final ProductUnit defaultUnit;

  Product({
    this.id,
    this.barcode,
    required this.name,
    required this.panjang,
    required this.categoryAge,
    required this.productSize,
    required this.variant,
    required this.type,
    required this.category,
    required this.supplier,
    required this.rack,
    required this.factory,
    required this.stock,
    required this.stockDisplay,
    required this.nominalPoint,
    required this.pointType,
    required this.defaultUnit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'] ?? "",
      barcode: json['barcode'] ?? "",
      name: json['product_name'] ?? "",
      categoryAge: json['kukuran'] ?? "",
      panjang: json['panjang'] ?? "",
      productSize: json['size_name'] ?? "",
      variant: json['variant_name'] ?? "",
      type: json['type_name'] ?? "",
      category: json['category_name'] ?? "",
      supplier: json['supplier_name'] ?? "",
      rack: json['rak'] ?? "",
      factory: json['factory'] ?? "",
      stock: FuncHelper().jsonStringToDouble(json['stock']),
      stockDisplay: FuncHelper().jsonStringToDouble(json['stock_display']),
      nominalPoint: FuncHelper().jsonStringToDouble(json['npoin']),
      pointType: ProductPointTypeExtension.generatePointType(json['jpoin']),
      defaultUnit: ProductUnit.fromJson(json),
    );
  }

  static List<ProductUnit> generateUnit(dynamic json) {
    var data = <ProductUnit>[];
    for (var item in json as List<Map<String, dynamic>>) {
      data.add(ProductUnit.fromJson(item));
    }
    return data;
  }

  static Map<String, dynamic> toJson({
    bool isEdit = false,
    String? id,
    required String code,
    required String name,
    required String rak,
    required String type,
    required String category,
    required String supplier,
    required String unit,
    required double buy,
    required double retail,
    required double partai,
    required double cabang,
    required double stok,
  }) {
    return {
      'user_id': GlobalVar.userId,
      'product_id': isEdit ? id! : code,
      if (isEdit) 'barcode': code,
      'product_name': name,
      'rak': rak,
      'type_name': type,
      'category_name': category,
      'supplier_name': supplier,
      'unit_name': unit,
      'buy': buy.toInt(),
      'retail': retail.toInt(),
      'partai': partai.toInt(),
      'cabang': cabang.toInt(),
      'date': FuncHelper().dateToDB(DateTime.now()),
      'buy_date': FuncHelper().dateToDB(DateTime.now()),
      'sale_date': FuncHelper().dateToDB(DateTime.now()),
      'stock': stok,
    };
  }

  String getName() {
    var value = name;
    if (panjang != '') {
      value += "  $panjang";
    }
    if (categoryAge != '') {
      value += "  $categoryAge";
    }
    if (productSize != '') {
      value += " - $productSize";
    }
    if (variant != '') {
      value += "  $variant";
    }
    return value;
  }

  String getInitialProduct() {
    return getInitialName(name);
  }
}
