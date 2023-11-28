import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/model/supplier.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppSupplierCard extends StatelessWidget {
  final bool isLast;
  final Supplier supplier;
  final Function()? onTap;
  const AppSupplierCard({
    super.key,
    required this.isLast,
    required this.supplier,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCardList(
        isLast: isLast,
        child: Row(
          children: [
            AppCardSquare(
              size: 48,
              margin: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  supplier.getInitial(),
                  style: AppTheme.nameInitialStyle,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        supplier.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.titleColor,
                        ),
                      ),
                    ),
                    Text(
                      supplier.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.capColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const AppSvgIcon(
              svg: svgChevronRight,
              size: 24,
              color: AppTheme.capColor,
            )
          ],
        ),
      ),
    );
  }
}
