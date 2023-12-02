import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_date_report.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_search.dart';

class AppBarTransaction extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String hintText;
  final bool showLeading;
  final bool searchMode;
  final Widget? leading;
  final TextEditingController controller;
  final Function(DateTime, DateTime) onTap;
  final Function() onChangedSearch;
  const AppBarTransaction({
    super.key,
    required this.title,
    required this.showLeading,
    required this.onTap,
    required this.searchMode,
    required this.onChangedSearch,
    required this.controller,
    required this.hintText,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppCustomAppBar(
      hideAppBar: searchMode,
      title: title,
      showLeading: showLeading,
      leading: leading,
      actions: [
        AppSvgIconBtn(
          svg: svgSearch,
          size: 16,
          color: AppTheme.titleColor,
          onTap: onChangedSearch,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AppDateReport(onSubmit: onTap),
        )
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Center(
          child: AppTextFieldSearchAppBar(
            hintText: hintText,
            controller: controller,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
