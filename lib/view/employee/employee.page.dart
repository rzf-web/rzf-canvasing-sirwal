import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/model/employee.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/employee/employee.controller.dart';
import 'package:rzf_canvasing_sirwal/view/employee/widget/app_employee_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class EmployeePage extends GetView<EmployeeController> {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        showLeading: false,
        title: "Pegawai",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppSvgIconBtn(
              svg: svgLogout,
              onTap: controller.logout,
              size: 16,
              color: AppTheme.titleColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.employees().isEmpty && !controller.isLoading.value)
              const AppDataNotFound(),
            if (controller.isLoading.value)
              const AppLoading()
            else
              AppRemoveOverscroll(
                child: RefreshIndicator(
                  onRefresh: controller.getData,
                  color: AppTheme.primaryColor,
                  child: ListView.builder(
                    itemCount: controller.employees().length,
                    itemBuilder: (context, index) {
                      late Employee employee;
                      if (controller.employees().isNotEmpty) {
                        employee = controller.employees().elementAt(index);
                      }
                      return AppEmployeeCard(
                        isLast: false,
                        employee: employee,
                        onTap: () => controller.passwordPage(employee),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
