import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_tsx_product_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_smart_refresh.dart';

class AppTsxProductList extends GetView<TsxProductListController> {
  const AppTsxProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRemoveOverscroll(
      child: AppSmartRefresh(
        onRefresh: () => controller.refreshData(),
        onLoading: () => controller.loadData(),
        controller: controller.refreshController,
        noData: controller.isLastPage.value,
        child: Obx(
          () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ...controller.productList().map(
                (element) {
                  var similarProducts = element
                      .getSimilarProductOnCart(controller.productOnCarts)
                      .obs;
                  return AppTsxProductCard(
                    product: element,
                    customer: controller.customer.value,
                    similarProducts: similarProducts,
                    productOnCart: controller.productOnCarts.firstWhereOrNull(
                      (e) => e.id == element.id && e.barcode == element.barcode,
                    ),
                    onChanged: (v) => {
                      controller.onProductChanged(v),
                      similarProducts.refresh(),
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
