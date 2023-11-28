import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/product_unit.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_qty_unit_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';

class AppTsxProductCard extends StatefulWidget {
  final ProductOnCart product;
  final ProductUnitPrice priceType;
  final Function(ProductOnCart) onChanged;
  const AppTsxProductCard({
    super.key,
    required this.product,
    required this.onChanged,
    required this.priceType,
  });

  @override
  State<AppTsxProductCard> createState() => _AppTsxProductCardState();
}

class _AppTsxProductCardState extends State<AppTsxProductCard> {
  var baseStock = 0.0;
  var group = '';
  var onCart = 0.obs;
  var stock = 0.0.obs;
  var unit = Rx<ProductUnit?>(null);

  addProduct() {
    if (stock > 0 || widget.product.transaction.isBuy) {
      // onCart.value++;
      // if (!widget.product.transaction.isBuy) stock.value--;
      // onChanged();
      showBottomBar(
        AppTsxQtyUnitDialog(
          product: widget.product,
          priceType: widget.priceType,
          onCart: onCart.value,
          initialUnit: unit.value,
          onDone: pickUnit,
        ),
      );
    } else {
      showSnackbar("Stok produk habis", const Color(0xFFFDBF44));
    }
  }

  removeProduct() {
    if (onCart > 0) {
      onCart.value--;
      if (!widget.product.transaction.isBuy) stock.value++;
      if (unit.value != null &&
          unit.value!.unit != widget.product.defaultUnit.unit) {
        unit.value = widget.product.defaultUnit;
      }
      onChanged();
    }
  }

  onChanged() {
    var productOnCart = ProductOnCart(
      id: widget.product.id,
      buyDate: widget.product.buyDate,
      name: widget.product.name,
      type: widget.product.type,
      category: widget.product.category,
      supplier: widget.product.supplier,
      transaction: widget.product.transaction,
      defaultUnit: widget.product.defaultUnit,
      group: group,
      rack: widget.product.rack,
      factory: widget.product.factory,
      stock: widget.product.stock,
      minStock: widget.product.minStock,
      priceType: widget.priceType,
      unit: unit.value!,
      onCart: onCart.value,
    );

    widget.onChanged(productOnCart);
  }

  initialize() {
    group = widget.product.group;
    unit.value = widget.product.unit ?? widget.product.defaultUnit;
    onCart.value = widget.product.onCart;
    baseStock = widget.product.stock;
    if (!widget.product.transaction.isBuy) {
      stock.value = baseStock - onCart.value;
    } else {
      stock.value = baseStock;
    }
  }

  pickUnit(int qty, ProductUnit unit, String group) {
    Get.back();
    onCart.value = qty;
    this.group = group;
    widget.product.group = group;
    if (!widget.product.transaction.isBuy) stock.value = baseStock - qty;
    this.unit.value = unit;
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return GestureDetector(
      onTap: addProduct,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
        ),
        child: Row(
          children: [
            AppCardSquare(
              size: 48,
              margin: const EdgeInsets.only(right: 16),
              child: Center(
                child: Obx(
                  () => Text(
                    "${onCart.value}",
                    style: AppTheme.nameInitialStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppTheme.titleColor,
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      var price = unit.value!.getPrice(
                          widget.priceType, widget.product.transaction);
                      return Obx(
                        () => Text(
                          "Stok ${doubleFormatter(stock.value)} - ${moneyFormatter(price)}/${unit.value!.unit}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.capColor,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: removeProduct,
              child: Container(
                width: 48,
                height: 48,
                margin: const EdgeInsets.only(left: 8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secBgColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.remove,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
