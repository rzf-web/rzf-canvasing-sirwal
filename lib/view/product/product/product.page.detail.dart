import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/product/product/product.controller.detail.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_key_value_item.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: AppCustomAppBar(
        title: "Detail Produk",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: AppSvgIconBtn(
              svg: svgTrash,
              onTap: controller.onRemove,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          AppRemoveOverscroll(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: Obx(
                  () => Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            AppCardSquare(
                              size: 48,
                              margin: const EdgeInsets.only(right: 14),
                              child: Center(
                                child: Text(
                                  controller.data.value.getInitialProduct(),
                                  style: AppTheme.nameInitialStyle,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.data.value.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.titleColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppKeyValueItem(
                        keyItem: "ID",
                        value: controller.data.value.id!,
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Pabrik",
                        value: controller.data.value.factory,
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Supplier",
                        value: controller.data.value.supplier,
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Kategori",
                        value: controller.data.value.category,
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Jenis",
                        value: controller.data.value.type,
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Rak",
                        value: controller.data.value.rack,
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Stok",
                        value: doubleFormatter(controller.data.value.stock),
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Min Stok",
                        value:
                            doubleFormatter(controller.data.value.stockDisplay),
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Harga Beli",
                        value: moneyFormatter(
                          controller.data.value.defaultUnit.buy,
                        ),
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Harga Retail",
                        value: moneyFormatter(
                          controller.data.value.defaultUnit.retail,
                        ),
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Harga Partai",
                        value: moneyFormatter(
                          controller.data.value.defaultUnit.partai,
                        ),
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppKeyValueItem(
                        keyItem: "Harga Cabang",
                        value: moneyFormatter(
                          controller.data.value.defaultUnit.cabang,
                        ),
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      AppButton(
                        borderRadius: 4,
                        color: AppTheme.secBgColor,
                        onPressed: controller.detailUnit,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Detail Multi Satuan",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.titleColor,
                                ),
                              ),
                            ),
                            AppSvgIcon(
                              svg: svgChevronRight,
                              size: 24,
                              color: AppTheme.titleColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 110)
                    ],
                  ),
                ),
              ),
            ),
          ),
          AppFixedBottomBtn(
            onPressed: controller.onEditBtnClick,
            showShadow: false,
            child: const Text("Edit", style: AppTheme.btnStyle),
          ),
        ],
      ),
    );
  }
}
