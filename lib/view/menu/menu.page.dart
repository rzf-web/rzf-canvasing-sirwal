import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/menu/menu.controller.dart';
import 'package:rzf_canvasing_sirwal/view/menu/widget/app_header_profile.dart';
import 'package:rzf_canvasing_sirwal/widget/app_menu_tile.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppMenuPage extends GetView<AppMenuController> {
  final Function() onClose;
  const AppMenuPage({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    controller.resetDelay();
    const padding = AppTheme.mobilePadding;
    const titleMenuStyle = TextStyle(
      fontSize: 14,
      color: AppTheme.titleColor,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      body: SafeArea(
        child: AppRemoveOverscroll(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: padding - 12,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        AppSvgIconBtn(
                          size: 28,
                          svg: svgClose,
                          color: AppTheme.bodyColor,
                          onTap: onClose,
                        ),
                        const Text(
                          "Menu utama",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.bodyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeIn(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: AppHeaderProfile(
                      img: GlobalVar.profile!.photo,
                      name: GlobalVar.profile!.name,
                      onLogout: controller.logout,
                    ),
                  ),
                ),
                animation(
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding,
                      vertical: 8,
                    ),
                    child: Text(
                      "Master",
                      style: titleMenuStyle,
                    ),
                  ),
                ),
                ...controller.menuMaster.map(
                  (e) => animation(AppMenuTile(
                    svg: e['icon']!,
                    title: e['title']!,
                    horiPadding: AppTheme.mobilePadding,
                    color: AppTheme.bodyColor,
                    onTap: () => controller.onMenuTap(e['route']!),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  animation(Widget child) {
    return FadeInLeft(from: 10, delay: controller.getDelay(), child: child);
  }
}
