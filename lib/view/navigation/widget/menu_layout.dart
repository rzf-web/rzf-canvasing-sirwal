import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/menu/menu.page.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/widget/blur_layer.dart';

class MenuLayout extends StatefulWidget {
  final bool show;
  final BoxConstraints constraints;
  final Function() onClose;
  final Function() onEnd;
  const MenuLayout({
    super.key,
    required this.constraints,
    required this.show,
    required this.onClose,
    required this.onEnd,
  });

  @override
  State<MenuLayout> createState() => _MenuLayoutState();
}

class _MenuLayoutState extends State<MenuLayout> {
  var showBlur = false.obs;
  var showContainer = false.obs;
  var showMenu = false.obs;

  run() {
    if (widget.show) {
      forward();
    } else {
      reverse();
    }
  }

  forward() async {
    await Future.delayed(const Duration(milliseconds: 130));
    showBlur.value = true;
    await Future.delayed(const Duration(milliseconds: 100));
    showContainer.value = true;
  }

  reverse() async {
    showMenu.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
    showContainer.value = false;
    await Future.delayed(const Duration(milliseconds: 200));
    showBlur.value = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    run();
    var display = widget.constraints;
    return Obx(
      () => Stack(
        children: [
          BlurLayer(
            width: double.infinity,
            height: display.maxHeight,
            show: showBlur.value,
            onEnd: widget.onEnd,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              onEnd: () {
                if (widget.show) showMenu.value = true;
              },
              duration: const Duration(milliseconds: 300),
              height: showContainer.value ? display.maxHeight : 0,
              width: double.infinity,
              color: Colors.white,
              curve: Curves.easeIn,
              child: Stack(
                children: [
                  if (showMenu.value) AppMenuPage(onClose: widget.onClose)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
