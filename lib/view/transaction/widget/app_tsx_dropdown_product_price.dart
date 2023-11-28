import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/product_unit.enum.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down.dart';

class AppTsxDropDownProductPrice extends StatefulWidget {
  final Function(ProductUnitPrice) onChanged;
  const AppTsxDropDownProductPrice({super.key, required this.onChanged});

  @override
  State<AppTsxDropDownProductPrice> createState() =>
      _AppTsxDropDownProductPriceState();
}

class _AppTsxDropDownProductPriceState
    extends State<AppTsxDropDownProductPrice> {
  var priceUnit = ProductUnitPrice.retail.name.capitalizeFirst!.obs;

  onChanged(String? v) {
    priceUnit.value = v!;
    widget.onChanged(getProductPrice(v));
  }

  ProductUnitPrice getProductPrice(String string) {
    for (var item in ProductUnitPrice.values) {
      if (string.toLowerCase() == item.name) {
        return item;
      }
    }
    return ProductUnitPrice.retail;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppDropDown(
        hintText: "Jenis Jual",
        label: "Pilih jenis jual",
        value: priceUnit.value,
        onChanged: onChanged,
        items: ProductUnitPrice.values
            .map((e) => e.name.capitalizeFirst!)
            .toList(),
      ),
    );
  }
}
