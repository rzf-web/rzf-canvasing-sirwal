import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/model/employee.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppEmployeeCard extends StatelessWidget {
  final bool isLast;
  final Employee employee;
  final Function() onTap;
  const AppEmployeeCard({
    super.key,
    required this.isLast,
    required this.onTap,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCardList(
        isLast: isLast,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              AppCardSquare(
                size: 48,
                margin: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    employee.getInitial(),
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
                          employee.user,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.titleColor,
                          ),
                        ),
                      ),
                      Text(
                        employee.cabang,
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
      ),
    );
  }
}
