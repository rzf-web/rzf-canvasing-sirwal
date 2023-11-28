import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppCashFlowTabbar extends StatefulWidget {
  final List<String> tabBars;
  final TabController controller;
  const AppCashFlowTabbar({
    super.key,
    required this.controller,
    required this.tabBars,
  });

  @override
  State<AppCashFlowTabbar> createState() => _AppCashFlowTabbarState();
}

class _AppCashFlowTabbarState extends State<AppCashFlowTabbar> {
  var activeIndex = 0.obs;

  @override
  void initState() {
    widget.controller.addListener(() {
      var index = widget.controller.index;
      activeIndex.value = index;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      child: Container(
        height: 38,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: TabBar(
          controller: widget.controller,
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(1),
          tabs: widget.tabBars
              .asMap()
              .map(
                (index, value) => MapEntry(
                  index,
                  Tab(
                    child: Obx(
                      () => Text(
                        value,
                        style: TextStyle(
                          color: activeIndex.value == index
                              ? AppTheme.primaryColor
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      ),
    );
  }
}
