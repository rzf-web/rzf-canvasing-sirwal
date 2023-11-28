import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.controller.add.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.page.dart';

class BuyAddPage extends GetView<BuyAddController> {
  const BuyAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TsxProductList(
        type: TransactionType.buy,
        appBartitle: "Transaksi Pembelian",
        onSave: controller.paymentPage,
        clearCart: controller.clearCart.value,
      ),
    );
  }
}
