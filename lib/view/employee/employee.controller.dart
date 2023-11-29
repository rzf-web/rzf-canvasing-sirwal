import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/employee.data.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/model/employee.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/view/employee/employee.page.password.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class EmployeeController extends GetxController {
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  var loginLoading = false.obs;
  Employee? employee;
  var employees = <Employee>[].obs;

  Future<void> getData() async {
    isLoading.value = true;
    employees.value = await EmployeeData().fetchData();
    isLoading.value = false;
  }

  login() async {
    if (passwordController.text != '') {
      loginLoading.value = true;
      var response = await ApiService.post(
        url + employeeLoginUrl,
        data: setFormData(
          {
            "user_id": GlobalVar.userId,
            "username": employee!.user,
            "password": passwordController.text,
          },
        ),
      );
      loginLoading.value = false;
      var success = await manageResponse(response);
      if (success) {
        var data = getDataResponse(response)['data'] ?? {};
        passwordController.clear();
        for (var item in data.keys) {
          print("$item => ${data[item]}");
        }
      }
    } else {
      showDialogAction(
        ActionDialog.warning,
        'Masukan password yang valid dengan akun Anda!!!',
      );
    }
  }

  passwordPage(Employee employee) async {
    this.employee = employee;
    await Get.to(const EmployeePasswordPage());
    this.employee = null;
    passwordController.clear();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
