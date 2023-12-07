import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';
import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_product_list.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_product_oncart_btn.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_search_scan.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';

class TsxProductList extends GetView<TsxProductListController> {
  final String appBartitle;
  final TransactionType type;
  final Future<bool> Function(List<ProductOnCart>, Customer) onSave;
  const TsxProductList({
    super.key,
    required this.type,
    required this.appBartitle,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    controller.onSave = onSave;
    controller.transactionType = type;
    return Scaffold(
      appBar: AppCustomAppBar(title: appBartitle),
      body: Obx(
        () => Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                AppTsxSearchScan(
                  controller: controller.searchController,
                  onBtnClick: controller.onBtnScanClick,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
                  child: Text(
                    "Pilih Produk",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Obx(
                      () => Stack(
                        children: [
                          if (controller.productList().isEmpty &&
                              !controller.isLoading.value)
                            const Padding(
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: AppDataNotFound(height: 150, width: 206),
                            ),
                          if (controller.isLoading.value)
                            const AppLoading()
                          else
                            const AppTsxProductList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (controller.totalProduct.value != 0)
              Obx(
                () => AppTsxProductOnCartBtn(
                  onPressed: controller.cartPage,
                  total: controller.total.value,
                  productCount: controller.totalProduct.value,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
