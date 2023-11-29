import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/model/employee.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/employee/employee.controller.dart';
import 'package:rzf_canvasing_sirwal/view/employee/widget/app_employee_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class EmployeePage extends GetView<EmployeeController> {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(
        showLeading: false,
        title: "Pegawai",
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
