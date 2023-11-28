import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;
  final bool hideAppBar;
  final bool showBorder;
  final Widget? leading;
  final Widget? child;
  final List<Widget>? actions;
  const AppCustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.child,
    this.showLeading = true,
    this.hideAppBar = false,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hideAppBar ? 100 : null,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor,
            width: showBorder ? 1 : 0,
          ),
        ),
      ),
      child: hideAppBar ? SafeArea(child: FadeIn(child: child!)) : appBar(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget leadingBtn() {
    return AppSvgIconBtn(
      svg: svgArrowLeft,
      size: 20,
      color: AppTheme.titleColor,
      onTap: Get.back,
    );
  }

  Widget appBar() {
    return FadeIn(
      child: AppBar(
        leading: showLeading ? leading ?? leadingBtn() : const SizedBox(),
        title: Text(title),
        actions: actions,
      ),
    );
  }
}
