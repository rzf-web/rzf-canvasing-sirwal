import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_cart_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class TsxProductCartPage extends GetView<TsxProductListController> {
  const TsxProductCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: const AppCustomAppBar(title: "Keranjang Belanja"),
      body: Column(
        children: [
          Expanded(
            child: AppRemoveOverscroll(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: Obx(
                  () => ListView(
                    children: [
                      const SizedBox(height: padding),
                      ...controller.productOnCarts().map(
                            (e) => AppCartCard(
                              product: e,
                              isLast:
                                  controller.productOnCarts().last.id == e.id,
                              onRemove: controller.onRemoveFromCart,
                            ),
                          ),
                      const SizedBox(height: padding),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AppFixedBottomBtn(
            onPressed: controller.onCartSave,
            child: const Text("Lanjutkan", style: AppTheme.btnStyle),
          ),
        ],
      ),
    );
  }
}
