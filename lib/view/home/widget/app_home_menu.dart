import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/home/widget/app_home_menu_card.dart';

class AppHomeMenu extends StatelessWidget {
  final List<Map<String, String>> menu;
  final Function(String) onMenuTap;
  const AppHomeMenu({
    super.key,
    required this.menu,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...menu.map(
            (e) => AppHomeMenuCard(
              svg: e['icon']!,
              title: e['title']!,
              onTap: () => onMenuTap(e['route']!),
            ),
          )
        ],
      ),
    );
  }
}
