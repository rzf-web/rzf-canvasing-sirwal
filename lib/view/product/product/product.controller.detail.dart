import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class ProductDetailController extends GetxController {
  final data = (Get.arguments as Product).obs;

  onEditBtnClick() async {
    var productId = await Get.toNamed(
      Routes.productUpdate,
      arguments: data.value,
    );
    if (productId != null) {
      await initData(productId);
    }
  }

  onRemove() {
    showDialogAction(
      ActionDialog.confirm,
      "Apakah Anda yakin ingin menghapus produk tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          "$url$productUrl",
          data: getParamQuery(query: {'product_id': data.value.id!}),
        );
        Get.back();
        var success = await manageResponse(response);
        if (success) {
          Get.back();
        }
      },
    );
  }

  initData(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    waitingDialog();
    var response = await ApiService.get(
      "$url$productUrl",
      queryParameters: getParamQuery(query: {'product_id': id}),
    );
    Get.back();
    var newData = getDataResponse(response)['data'];
    data.value = Product.fromJson(newData);
  }

  detailUnit() async {
    var updated = await Get.toNamed(
      Routes.productDetailMultiUnit,
      arguments: data.value,
    );
    if (updated != null) {
      await initData(data.value.id!);
    }
  }
}
