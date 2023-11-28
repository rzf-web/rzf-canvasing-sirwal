import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_multi_unit/product.controller.detail_multi_unit.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_unit_col_body.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_unit_col_header.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class AppProductMultiUnitList extends GetView<ProductMultiUnitController> {
  const AppProductMultiUnitList({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Column(
      children: [
        const SizedBox(height: padding),
        AppUnitColHeader(
          onChanged: (v) => controller.unitPrice.value = v,
        ),
        AppRemoveOverscroll(
          child: RefreshIndicator(
            onRefresh: () => controller.getMultiUnit(),
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ...controller.multiSat().map(
                      (e) => Obx(
                        () => GestureDetector(
                          onTap: () => controller.editMultiUnit(unit: e),
                          child: AppUnitColBody(
                            unit: e,
                            onRemove: () => controller.onRemove(e),
                            unitPrice: controller.unitPrice.value,
                            isDefaultUnit: controller.isDefaultUnit(e),
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: padding),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
