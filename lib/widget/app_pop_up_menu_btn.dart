import 'package:flutter/material.dart';

class AppPopUpMenuBtn extends StatelessWidget {
  final List<PopupMenuEntry<dynamic>> menu;
  final Widget child;
  const AppPopUpMenuBtn({
    super.key,
    required this.child,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      shadowColor: const Color(0xFFACACAC).withOpacity(0.2),
      position: PopupMenuPosition.under,
      offset: const Offset(0, 0),
      elevation: 4,
      itemBuilder: (context) => menu,
      child: child,
    );
  }
}
