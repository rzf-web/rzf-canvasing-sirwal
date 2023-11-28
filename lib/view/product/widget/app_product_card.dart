import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';

class AppProductCard extends StatelessWidget {
  final bool isLast;
  final Product product;
  final Function() onTap;
  const AppProductCard({
    super.key,
    required this.isLast,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const captionStyle = TextStyle(
      fontSize: 14,
      color: AppTheme.capColor,
    );
    return GestureDetector(
      onTap: onTap,
      child: AppCardList(
        isLast: isLast,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCardSquare(
              size: 48,
              margin: const EdgeInsets.only(right: 14),
              child: Center(
                child: Text(
                  product.getInitialProduct(),
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
                    child: nameUnit(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: codeJual(captionStyle),
                  ),
                  Text(
                    "Harga beli ${moneyFormatter(product.defaultUnit.buy)}",
                    style: captionStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameUnit() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        product.name,
        style: const TextStyle(
          fontSize: 16,
          color: AppTheme.titleColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget codeJual(TextStyle captionStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(product.id!, style: captionStyle),
        ),
        Expanded(
          child: Text(
            moneyFormatter(product.defaultUnit.partai),
            textAlign: TextAlign.end,
            style: captionStyle,
          ),
        ),
      ],
    );
  }
}
