import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/employee/employee.page.password.dart';

class EmployeeController extends GetxController {
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  var employees = ['test', 'test', 'test'].obs;

  passwordPage() => Get.to(const EmployeePasswordPage());
}
