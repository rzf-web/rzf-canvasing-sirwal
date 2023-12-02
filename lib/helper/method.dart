import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/enum/product_point_type.dart';

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
  ) {
    var total = price * qty;
    var point = 0;
    switch (pointType) {
      case ProductPointType.productQty:
        point = qty ~/ nPoint;
        break;
      case ProductPointType.productPrice:
        point = total ~/ nPoint;
        break;
      case ProductPointType.totalTransaction:
        nPoint = GlobalVar.employee!.nominalPoint;
        point = total ~/ nPoint;
        break;
    }

    return point;
  }
}
