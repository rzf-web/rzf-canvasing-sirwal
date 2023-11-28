import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<Map<String, dynamic>> menu;
  final Function(int) onChanged;
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.menu,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 4.0,
      selectedFontSize: 12,
      onTap: onChanged,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: AppTheme.primaryColor,
      backgroundColor: const Color(0xFFFFFFFF),
      unselectedLabelStyle: const TextStyle(color: Color(0xFF252525)),
      items: [
        ...menu.map(
          (e) => BottomNavigationBarItem(
            icon: icon(e['icon'], color: const Color(0xFF252525)),
            activeIcon: icon(e['icon'], color: AppTheme.primaryColor),
            label: e['title'],
            tooltip: e['title'],
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget icon(String svg, {required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: AppSvgIcon(svg: svg, size: 16, color: color),
    );
  }
}
