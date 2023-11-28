import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/mutasi_kas.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppMutasiKasCard extends StatelessWidget {
  final MutasiKas data;
  final bool isLast;
  const AppMutasiKasCard({super.key, required this.data, required this.isLast});

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
                data.getInitial(),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                data.source,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.titleColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Transform.rotate(
                                angle: pi,
                                child: const AppSvgIcon(
                                  size: 12,
                                  svg: svgArrowLeft,
                                  color: AppTheme.capColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                data.destination,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.titleColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        moneyFormatter(data.nominal),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    dateFormatUI(data.date),
                    style: const TextStyle(
                      color: AppTheme.capColor,
                    ),
                  ),
                ),
                Text(
                  data.note,
                  style: const TextStyle(
                    color: AppTheme.capColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
