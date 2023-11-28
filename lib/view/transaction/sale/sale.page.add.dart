import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.controller.add.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.page.dart';

class SaleAddPage extends GetView<SaleAddController> {
  const SaleAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TsxProductList(
        type: TransactionType.sale,
        appBartitle: "Transaksi Penjualan",
        onSave: controller.paymentPage,
        clearCart: controller.clearCart.value,
      ),
    );
  }
}
