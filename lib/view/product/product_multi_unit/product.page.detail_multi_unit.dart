import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_multi_unit/app_product_multi_unit_list.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_multi_unit/product.controller.detail_multi_unit.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';

class ProductDetailMultiUnitPage extends GetView<ProductMultiUnitController> {
  const ProductDetailMultiUnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: const AppCustomAppBar(
        title: "Detail Multi Satuan",
        actions: [],
      ),
      body: Obx(
        () => Column(
          children: [
            if (controller.isLoading.value)
              const Expanded(child: AppLoading())
            else
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: AppProductMultiUnitList(),
                ),
              ),
            AppFixedBottomBtn(
              onPressed: controller.editMultiUnit,
              child: const Text(
                "Tambah Multi Satuan",
                style: AppTheme.btnStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
