import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppTsxProductOnCartBtn extends StatelessWidget {
  final int productCount;
  final double total;
  final Function() onPressed;
  const AppTsxProductOnCartBtn({
    super.key,
    required this.total,
    required this.productCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppFixedBottomBtn(
      onPressed: onPressed,
      bgColor: Colors.transparent,
      showShadow: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            Text(
              "($productCount) Produk",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              moneyFormatter(total),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: AppSvgIcon(
                svg: svgChevronRight,
                size: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
