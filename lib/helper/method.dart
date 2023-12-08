import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/enum/product_point_type.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/product_price_type.enum.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';

class FuncHelper {
  Timer? debouncer;
  _debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 800),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  searchListener(
    TextEditingController controller,
    void Function(String) onChanged,
  ) async {
    var first = true;
    controller.addListener(() async {
      if (!first) {
        var value = controller.text;
        await _debounce(() async => onChanged(value));
      } else {
        first = false;
      }
    });
  }

  int jsonStringToInt(dynamic json) {
    return int.parse(json.toString());
  }

  double jsonStringToDouble(dynamic json) {
    return double.tryParse(json.toString()) ?? 0.0;
  }

  String dateToDB(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  int pointsCalculation(
    int qty,
    double price,
    double nPoint,
    ProductPointType pointType,
    List<ProductOnCart>? similarProducts,
  ) {
    var qtyOnCart = 0;
    var point = 0;
    if (similarProducts != null) {
      for (var item in similarProducts) {
        qtyOnCart += item.onCart;
      }
    }
    var total = price * (qty + qtyOnCart);

    switch (pointType) {
      case ProductPointType.productQty:
        point = (qty + qtyOnCart) ~/ nPoint;
        break;
      case ProductPointType.productPrice:
        point = total ~/ nPoint;
        break;
      case ProductPointType.totalTransaction:
        nPoint = GlobalVar.employee!.nominalPoint;
        point = total ~/ nPoint;
        break;
      case ProductPointType.nonPoint:
        break;
    }
    return point;
  }

  String getProductPriceLevelFromQtyLevel(int qty) {
    var qtyLevels = [1, 3, 6, 12, 100];
    if (qty >= qtyLevels[0] && qty < qtyLevels[1]) {
      return 'level1';
    }
    if (qty >= qtyLevels[1] && qty < qtyLevels[2]) {
      return 'level2';
    }
    if (qty >= qtyLevels[2] && qty < qtyLevels[3]) {
      return 'level3';
    }
    if (qty >= qtyLevels[3] && qty < qtyLevels[4]) {
      return 'level4';
    }
    if (qty >= qtyLevels[4]) {
      return 'level5';
    }
    return 'level1';
  }

  ProductPriceType getPriceFromCustomerLevels(
    int qty,
    Customer? customer,
    List<ProductOnCart>? similarProducts,
  ) {
    var similarProductQty = 0;
    if (similarProducts != null) {
      for (var item in similarProducts) {
        similarProductQty += item.onCart;
      }
    }
    var level = getProductPriceLevelFromQtyLevel(
      qty + similarProductQty,
    );
    var priceType = customer?.levels[level];
    return priceType ?? ProductPriceType.retail;
  }
}
