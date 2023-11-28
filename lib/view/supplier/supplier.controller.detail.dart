import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/model/supplier.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class SupplierDetailController extends GetxController {
  var data = (Get.arguments as Supplier).obs;

  onEditData() async {
    var result = await Get.toNamed(
      Routes.supplierUpdate,
      arguments: data.value,
    );
    if (result != null) {
      data.value = result as Supplier;
    }
  }

  onRemove() async {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus supplier tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        await Future.delayed(const Duration(milliseconds: 800));
        var response = await ApiService.delete(
          '$url$supplierUrl',
          data: _json(),
        );
        Get.back();
        var success = await manageResponse(response);
        if (success) {
          Get.back();
        }
      },
    );
  }

  Map<String, dynamic> _json() {
    return {"user_id": GlobalVar.userId, 'supplier_id': data.value.id};
  }
}
