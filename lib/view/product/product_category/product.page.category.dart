import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_category/product.controller.category.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_list_tile.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_search.dart';

class ProductCategoryPage extends GetView<ProductCategoryController> {
  const ProductCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(
            () => AppCustomAppBar(
              hideAppBar: controller.searchMode.value,
              title: "Kategori",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: AppSvgIconBtn(
                    svg: svgSearch,
                    size: 16,
                    color: AppTheme.titleColor,
                    onTap: controller.changeMode,
                  ),
                )
              ],
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: 8,
                ),
                child: Center(
                  child: AppTextFieldSearchAppBar(
                    hintText: "Cari Kategori",
                    controller: controller.searchController,
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onUpdateCategory,
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => Stack(
            children: [
              if (controller.categories().isEmpty &&
                  !controller.isLoading.value)
                const AppDataNotFound(),
              if (controller.isLoading.value)
                const AppLoading()
              else
                AppRemoveOverscroll(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: padding),
                    child: RefreshIndicator(
                      onRefresh: () async => await controller.getData(),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: padding),
                          ...controller.categories().map((e) => listTile(e)),
                          const SizedBox(height: padding + 60),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget listTile(String e) {
    return AppListTile(
      title: e,
      onTap: () => controller.onListTap(e),
      onLongPress: () => controller.onUpdateCategory(category: e),
      trailing: SizedBox(
        height: 30,
        width: 30,
        child: AppSvgIconBtn(
          svg: svgTrash,
          size: 20,
          color: Colors.red,
          onTap: () => controller.onRemove(e),
        ),
      ),
      isLast: controller.categories().last == e,
    );
  }
}
