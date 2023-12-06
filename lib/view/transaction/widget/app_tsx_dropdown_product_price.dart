import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/sale_type.enum.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down.dart';

class AppTsxDropDownProductPrice extends StatefulWidget {
  final Function(SaleType) onChanged;
  const AppTsxDropDownProductPrice({super.key, required this.onChanged});

  @override
  State<AppTsxDropDownProductPrice> createState() =>
      _AppTsxDropDownProductPriceState();
}

class _AppTsxDropDownProductPriceState
    extends State<AppTsxDropDownProductPrice> {
  var priceUnit = SaleType.retail.name.capitalizeFirst!.obs;

  onChanged(String? v) {
    priceUnit.value = v!;
    widget.onChanged(getProductPrice(v));
  }

  SaleType getProductPrice(String string) {
    for (var item in SaleType.values) {
      if (string.toLowerCase() == item.name) {
        return item;
      }
    }
    return SaleType.retail;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppDropDown(
        hintText: "Jenis Jual",
        label: "Pilih jenis jual",
        value: priceUnit.value,
        onChanged: onChanged,
        items: SaleType.values.map((e) => e.name.capitalizeFirst!).toList(),
      ),
    );
  }
}
