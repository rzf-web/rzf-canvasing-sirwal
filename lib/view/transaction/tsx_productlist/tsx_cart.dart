import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_productlist/tsx_productlist.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_cart_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class TsxProductCartPage extends GetView<TsxProductListController> {
  const TsxProductCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: const AppCustomAppBar(title: "Keranjang Belanja"),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: customerForm(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AppRemoveOverscroll(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: Obx(
                  () => ListView(
                    children: [
                      ...controller.productOnCarts().map(
                        (e) {
                          var similarProducts = e
                              .getSimilarProductOnCart(
                                controller.productOnCarts,
                              )
                              .obs;
                          return AppCartCard(
                            product: e,
                            isLast: controller.productOnCarts().last.id == e.id,
                            customer: controller.customer.value,
                            similarProducts: similarProducts(),
                            onRemove: controller.onRemoveFromCart,
                            onPointChanged: controller.countTotal,
                            onQtyChanged: similarProducts.refresh,
                          );
                        },
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

  Widget customerForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: AppTextFieldInput(
            label: "Nama Pelanggan",
            hintText: 'Pilih pelanggan...',
            readOnly: true,
            onTap: controller.personPage,
            controller: controller.personController,
          ),
        ),
        Container(
          height: 47,
          width: 47,
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppTheme.textFieldBorderColor),
            color: Colors.transparent,
          ),
          child: Center(
            child: Obx(
              () => Text(
                controller.point.value.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
