import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_profile_img_small.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppHeaderProfile extends StatelessWidget {
  final String img;
  final String name;
  final Function() onLogout;

  const AppHeaderProfile({
    super.key,
    required this.img,
    required this.name,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Container(
      width: double.infinity,
      color: AppTheme.secBgColor,
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: AppProfileImgSmall(img: img),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.titleColor,
                ),
              )
            ],
          ),
          AppSvgIconBtn(
            svg: svgLogout,
            size: 18,
            color: AppTheme.bodyColor,
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
