import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/navigation.controller.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/widget/menu_layout.dart';
import 'package:rzf_canvasing_sirwal/widget/app_bottom_nav.dart';

class NavigationPage extends GetView<NavigationController> {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onGetBack,
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              controller.getPage(),
              if (!controller.hideMenuLayer.value)
                LayoutBuilder(builder: (context, constraints) {
                  return Obx(
                    () => MenuLayout(
                      constraints: constraints,
                      show: controller.showMenu(),
                      onClose: controller.onMenuClose,
                      onEnd: controller.onAnimateMenuEnd,
                    ),
                  );
                }),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => AppBottomNav(
            menu: controller.menu,
            currentIndex: controller.navIndex.value,
            onChanged: controller.onNavChanged,
          ),
        ),
      ),
    );
  }
}
