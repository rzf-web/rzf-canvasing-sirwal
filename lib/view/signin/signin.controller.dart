import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/model/profile.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/services/shared/shared_pref.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  var rememberMe = false;
  var waiting = false.obs;

  login() async {
    Get.offAllNamed(Routes.employee);
    return;
    var valid = emailController.text != '' && pwController.text != '';
    if (valid) {
      waiting.value = true;
      var response = await ApiService.post(url + loginUrl, data: {
        'email': emailController.text,
        'password': pwController.text,
      });
      waiting.value = false;
      var success = await manageResponse(response);
      if (success) {
        var data = getDataResponse(response)['data'];
        GlobalVar.userId = int.parse(data['user_id'] ?? "0");
        GlobalVar.profile = Profile.fromJson(data);
        if (rememberMe) SharedPrefs.save(GlobalVar.userId);
        Get.offAllNamed(Routes.sale);
      }
    } else {
      showDialogAction(
        ActionDialog.warning,
        "Masukan email dan password yang valid!!!",
      );
    }
  }

  forgotPw() {}
}
