import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/product_price_type.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_btm_modal_discount.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_qty_unit_dialog.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppCartCard extends StatefulWidget {
  final bool isLast;
  final Customer? customer;
  final ProductOnCart product;
  final List<ProductOnCart> similarProducts;
  final Function(ProductOnCart) onRemove;
  final Function() onPointChanged;
  final Function() onQtyChanged;
  const AppCartCard({
    super.key,
    required this.product,
    required this.isLast,
    required this.onRemove,
    required this.onPointChanged,
    required this.customer,
    required this.similarProducts,
    required this.onQtyChanged,
  });

  @override
  State<AppCartCard> createState() => _AppCartCardState();
}

class _AppCartCardState extends State<AppCartCard> {
  var disPrecent = 0.0.obs;
  var disNominal = 0.0.obs;

  var qty = 0.obs;
  var stock = 0.0.obs;
  var baseStock = 0.0;

  var addActive = true.obs;
  var subActive = true.obs;

  var unit = Rx<ProductUnit?>(null);

  substractQty() {
    qty.value--;
    _changeUnitPoint();
    _setActiveQty();
    _pointsCalculation();
    widget.onQtyChanged();
  }

  addQty() {
    qty.value++;
    _changeUnitPoint();
    _setActiveQty();
    _pointsCalculation();
    widget.onQtyChanged();
  }

  _setActiveQty() {
    var stokOnCart = qty.value * unit.value!.isi!;
    //substract
    subActive.value = stokOnCart > 1;

    //add
    var isUnderStock = stokOnCart < stock.value;
    var isBuy = widget.product.transaction.isBuy;
    addActive.value = isUnderStock || isBuy;
  }

  _changeUnitPoint() {
    widget.product.onCart = (qty.value * unit.value!.isi!).toInt();
  }

  _pointsCalculation({bool isRemove = false}) {
    widget.customer?.setListPoint(
      [if (!isRemove) widget.product, ...widget.similarProducts],
    );
    widget.onPointChanged();
  }

  onRemove() {
    widget.onRemove(widget.product);
    widget.onQtyChanged();
    _pointsCalculation(isRemove: true);
  }

  pickUnit(int qty, ProductUnit unit, int point) {
    Get.back();
    if (qty != 0) {
      this.unit.value = unit;
      this.qty.value = qty ~/ unit.isi!;
      widget.product.onCart = this.qty.value;
      widget.product.unit = unit;
      widget.product.pointsEarned = point;
      _setActiveQty();
      widget.onPointChanged();
      widget.onQtyChanged();
    }
  }

  double getPricePercentaseFromLevel1Price() {
    var level1Price = _getLevel1Price();
    var nowPrice = _getPrice();
    var difference = level1Price - nowPrice;
    var percentase = (difference / level1Price) * 100;

    return percentase;
  }

  double _getLevel1Price() {
    var transactionType = widget.product.transaction;
    return unit.value!.getPrice(
      transactionType,
      priceType: FuncHelper().getPriceFromCustomerLevels(
        1,
        widget.customer,
        [],
      ),
    );
  }

  ProductPriceType getPriceType() {
    return FuncHelper().getPriceFromCustomerLevels(
      qty.value,
      widget.customer,
      widget.similarProducts,
    );
  }

  double _getPrice() {
    var transactionType = widget.product.transaction;
    return unit.value!.getPrice(transactionType, priceType: getPriceType());
  }

  int similarProductQty() {
    var qty = 0;
    for (var item in widget.similarProducts) {
      qty += item.onCart;
    }
    return qty;
  }

  initialize() {
    unit.value = widget.product.unit;
    qty.value = widget.product.onCart ~/ unit.value!.isi!;
    baseStock = widget.product.stock;
    stock.value = baseStock;

    _setActiveQty();
    if (widget.product.dscNominal != 0) {
      disNominal.value = widget.product.dscNominal;
      disPrecent.value = (disNominal.value / _getPrice()) * 100;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return GestureDetector(
      onTap: () => {
        showBottomBar(
          AppTsxQtyUnitDialog(
            product: widget.product,
            customer: widget.customer,
            similarProducts: widget.similarProducts,
            onCart: qty.value * unit.value!.isi!.toInt(),
            initialUnit: unit.value,
            onDone: pickUnit,
          ),
        )
      },
      child: AppCardList(
        isLast: widget.isLast,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCardSquare(
              size: 48,
              margin: const EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  widget.product.getInitial(),
                  textAlign: TextAlign.center,
                  style: AppTheme.nameInitialStyle,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: namePrice(),
                  ),
                  if ((qty.value + similarProductQty()) > 2)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Hemat : ",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.capColor,
                          ),
                          children: [
                            TextSpan(
                              text: numberFormatter(_getLevel1Price()),
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "   ${percentFormatter(getPricePercentaseFromLevel1Price())}%",
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Diskon : ${percentFormatter(disPrecent.value)}% | ${moneyFormatter(disNominal.value)}",
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.capColor,
                              ),
                            ),
                          ),
                          if (disNominal.value != 0.0)
                            Text(
                              moneyFormatter(_getPrice() - disNominal.value),
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.capColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      "Satuan : ${unit.value!.unit}",
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.capColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      qtyCount(),
                      const Spacer(),
                      AppSvgIconBtn(
                        svg: svgPercentCircle,
                        color: AppTheme.primaryColor,
                        onTap: () => {
                          showBottomBar(
                            AppBtmModalDiscount(
                              price: _getPrice(),
                              intitalPercent: disPrecent.value,
                              intitalNominal: disNominal.value,
                              onDone: (percent, nominal) {
                                disPrecent.value = percent;
                                disNominal.value = nominal;
                                widget.product.dscNominal = disNominal.value;
                                widget.product.dscPercent = disPrecent.value;
                                widget.onQtyChanged();
                                _pointsCalculation();
                              },
                            ),
                          ),
                        },
                      ),
                      AppSvgIconBtn(
                        svg: svgTrash,
                        color: Colors.red,
                        onTap: onRemove,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget namePrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.product.getName(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Obx(
            () => Text(
              moneyFormatter(_getPrice()),
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget qtyCount() {
    return Row(
      children: [
        Obx(() => button(Icons.remove, subActive.value, substractQty)),
        Container(
          color: Colors.white,
          width: 40,
          height: 30,
          child: Center(
            child: Obx(
              () => Text(
                "${qty.value}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        Obx(() => button(Icons.add, addActive.value, addQty)),
      ],
    );
  }

  Widget button(IconData icon, bool isActive, Function() onTap) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor : const Color(0xFFEEF2F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
