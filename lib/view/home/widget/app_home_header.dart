import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_profile_img_small.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppHomeHeader extends StatelessWidget {
  final Function() onTap;
  const AppHomeHeader({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
        vertical: 25,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: AppProfileImgSmall(img: GlobalVar.profile!.photo),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Text(
                  "Selamat Datang",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              Text(
                GlobalVar.profile!.username,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
          const Spacer(),
          AppSvgIconBtn(
            svg: svgLogout,
            color: Colors.white,
            size: 22,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
