import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/transaction_class.controller.dart';

class BuyAddController extends GetxController implements TsxAddController {
  var clearCart = false.obs;

  @override
  Future<void> paymentPage(List<ProductOnCart> data) async {
    clearCart.value = false;
    var result = await Get.toNamed(Routes.payment, arguments: {
      "type": TransactionType.buy,
      "data": data,
    });
    if (result != null) {
      var resultPay = result as Map<String, dynamic>;
      clearCart.value = resultPay['clear'] as bool;
    }
  }
}
