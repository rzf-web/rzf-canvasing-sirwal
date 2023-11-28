import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppPaymentSuggestionCard extends StatelessWidget {
  final String initial;
  final String name;
  final String address;
  const AppPaymentSuggestionCard({
    super.key,
    required this.initial,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCardSquare(
          size: 48,
          margin: const EdgeInsets.only(right: 16),
          child: Center(
            child: Text(
              initial,
              textAlign: TextAlign.center,
              style: AppTheme.nameInitialStyle,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF455A64),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.capColor,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: AppSvgIcon(
            svg: svgChevronRight,
            size: 24,
            color: AppTheme.capColor,
          ),
        ),
      ],
    );
  }
}
