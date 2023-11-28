import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';

class AppTransactionCard extends StatelessWidget {
  final String initial;
  final String name;
  final String date;
  final String address;
  final String total;
  final bool isLast;
  const AppTransactionCard({
    super.key,
    required this.initial,
    required this.name,
    required this.address,
    required this.total,
    required this.isLast,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardList(
      isLast: isLast,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardSquare(
            size: 48,
            margin: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                initial,
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
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.capColor,
                        ),
                      ),
                      Text(
                        total,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  address,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.capColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
