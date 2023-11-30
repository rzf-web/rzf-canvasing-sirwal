import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/product.data.unit.dart';
import 'package:rzf_canvasing_sirwal/enum/product_unit.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_number_keyboard.dart';

class AppTsxQtyUnitDialog extends StatefulWidget {
  final int onCart;
  final ProductUnit? initialUnit;
  final ProductOnCart product;
  final ProductUnitPrice priceType;
  final Function(int, ProductUnit, String) onDone;
  const AppTsxQtyUnitDialog({
    super.key,
    required this.onDone,
    required this.priceType,
    required this.product,
    required this.onCart,
    this.initialUnit,
  });

  @override
  State<AppTsxQtyUnitDialog> createState() => _AppTsxQtyUnitDialogState();
}

class _AppTsxQtyUnitDialogState extends State<AppTsxQtyUnitDialog> {
  var qty = 0.obs;
  var units = <ProductUnit>[];
  var unit = Rx<ProductUnit?>(null);
  var group = Rx<String?>(null);
  var loading = false.obs;
  var groups = <String>['Pribadi', 'Npwp'];

  fetchData() async {
    loading.value = true;
    qty.value = widget.onCart;
    units = await ProductUnitData().getProductUnit(widget.product.id!);
    if (widget.initialUnit == null) {
      unit.value = units.firstWhere((e) => e.isi == 1);
    } else {
      unit.value = widget.initialUnit;
      qty.value = qty.value ~/ unit.value!.isi!;
    }
    loading.value = false;
  }

  onDone() {
    var inputQty = (qty.value * unit.value!.isi!).toInt();
    if (unit.value != null && !loading.value) {
      if (_stokValidation()) {
        widget.onDone(inputQty, unit.value!, group.value!);
      }
    }
  }

  bool _stokValidation() {
    var stock = widget.product.stock;
    var inputQty = qty.value * unit.value!.isi!;
    if (inputQty <= stock || widget.product.transaction.isBuy) {
      return true;
    }
    showSnackbar("Jumlah melebihi stok produk", const Color(0xFFFFFFFF));
    return false;
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          if (widget.product.transaction.isBuy)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Obx(
                () => AppDropDown(
                  label: "Group",
                  hintText: "Pilih group",
                  value: group.value,
                  items: groups,
                  onChanged: (v) => group.value = v!,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: unitsList(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Expanded(child: unitsDropDown()),
                const SizedBox(width: 10),
                Expanded(child: qtyTextField()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: AppNumKeyboard(
              initial: qty.value,
              onChanged: (v) => qty.value = v,
            ),
          ),
          AppButton(
            onPressed: onDone,
            child: const Text("Selesai", style: AppTheme.btnStyle),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget unitsDropDown() {
    return Obx(
      () => AppDropDown(
        label: "Satuan",
        hintText: "Satuan",
        value: unit.value?.unit,
        items: units.map((e) => e.unit).toList(),
        onChanged: (v) => unit.value = units.firstWhere((e) => e.unit == v),
        decoration: BoxDecoration(
          color: AppTheme.secBgColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget qtyTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Jumlah Qty",
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.titleColor,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: AppTheme.secBgColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Obx(
              () => Text(
                qty.value.toInt().toString(),
                style: const TextStyle(
                  color: AppTheme.titleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget unitsList() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Satuan Terpilih",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.titleColor,
              ),
            ),
          ),
          if (loading.value)
            const Padding(
              padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
              child: AppLoading(indicatorSize: 20, fontSize: 12),
            )
          else
            unitCard(unit.value!),
        ],
      ),
    );
  }

  Widget unitCard(ProductUnit e) {
    return GestureDetector(
      onTap: () => unit.value = e,
      child: Row(
        children: [
          Text(
            e.unit,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            e.isi!.toInt().toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            moneyFormatter(
                e.getPrice(widget.priceType, widget.product.transaction)),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget checkBox(bool active) {
    return SizedBox(
      width: 14,
      height: 14,
      child: Checkbox(
        activeColor: AppTheme.primaryColor,
        value: active,
        onChanged: (_) {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
