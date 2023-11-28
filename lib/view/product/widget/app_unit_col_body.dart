import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/product.unit.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppUnitColBody extends StatefulWidget {
  final bool isDefaultUnit;
  final ProductUnit unit;
  final String unitPrice;
  final Function() onRemove;
  const AppUnitColBody({
    super.key,
    required this.unit,
    required this.isDefaultUnit,
    required this.unitPrice,
    required this.onRemove,
  });

  @override
  State<AppUnitColBody> createState() => _AppUnitColBodyState();
}

class _AppUnitColBodyState extends State<AppUnitColBody> {
  var textStyle = const TextStyle(
    fontSize: 14,
    color: AppTheme.titleColor,
    fontFamily: AppTheme.fontFamily,
  );

  double getPrice() {
    switch (widget.unitPrice) {
      case "Harga Partai":
        return widget.unit.partai;
      case "Harga Cabang":
        return widget.unit.cabang;
      default:
        return widget.unit.retail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(bottom: 8, top: 6),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.borderColor, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(widget.unit.unit, style: textStyle),
            ),
            Expanded(
              flex: 1,
              child: Text(
                doubleFormatter(widget.unit.isi!),
                style: textStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  moneyFormatter(getPrice()),
                  style: textStyle,
                ),
              ),
            ),
            Container(
              width: 42,
              color: Colors.transparent,
              child: AppSvgIconBtn(
                size: 16,
                svg: svgTrash,
                color: widget.isDefaultUnit ? Colors.transparent : Colors.red,
                onTap: widget.isDefaultUnit ? null : widget.onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
