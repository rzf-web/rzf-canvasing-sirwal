import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/validatior.dart';
import 'package:rzf_canvasing_sirwal/model/product.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/product/product/product.controller.update.dart';
import 'package:rzf_canvasing_sirwal/view/product/widget/app_multi_unit_form.dart';
import 'package:rzf_canvasing_sirwal/widget/app_clear_suffix_icon.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_action.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class ProductUpdatePage extends GetView<ProductUpdateController> {
  const ProductUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: AppCustomAppBar(
        title:
            '${controller.data != null && controller.data is Product ? "Edit" : "Tambah"} Data Produk',
      ),
      body: Column(
        children: [
          Expanded(
            child: AppRemoveOverscroll(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Form(
                    key: controller.detailFormKey,
                    child: Obx(
                      () => Column(
                        children: [
                          const SizedBox(height: padding),
                          AppTextFieldAction(
                            label: "ID Produk",
                            hintText: "ID Produk",
                            controller: controller.idController,
                            onActionTap: controller.scanProduct,
                            padding: const EdgeInsets.only(bottom: 16),
                            suffixIcon: getCodeSuffixIcon(),
                            iconAction: const AppSvgIcon(
                              svg: svgBarcode,
                              size: 24,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Tanggal",
                              hintText: "Pilih tanggal",
                              readOnly: true,
                              onTap: controller.pickDate,
                              controller: controller.lastDateBuyController,
                              validator: (v) => emptyValidator("Tanggal", v!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppDropDown(
                              label: "Group",
                              hintText: "Pilih group",
                              value: controller.group.value,
                              items: controller.groups,
                              onChanged: controller.changeGroup,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Nama Produk",
                              hintText: "Masukan nama produk",
                              controller: controller.nameController,
                              textInputAction: TextInputAction.next,
                              validator: (v) =>
                                  emptyValidator("Nama produk", v!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Jenis Produk",
                              hintText: "Pilih jenis",
                              readOnly: true,
                              onTap: controller.productTypePage,
                              controller: controller.typeController,
                              suffixIcon:
                                  const AppSuffixIcon(svg: svgDotsHorizontal),
                              validator: (v) => emptyValidator("jenis", v!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Nama Rak",
                              hintText: "Pilih rak",
                              readOnly: true,
                              onTap: controller.rackPage,
                              controller: controller.rackController,
                              suffixIcon:
                                  const AppSuffixIcon(svg: svgDotsHorizontal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Kategori",
                              hintText: "Pilih kategori",
                              readOnly: true,
                              onTap: controller.categoryPage,
                              controller: controller.categoryController,
                              suffixIcon:
                                  const AppSuffixIcon(svg: svgDotsHorizontal),
                              validator: (v) => emptyValidator("Kategori", v!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Nama Pabrik",
                              hintText: "Pilih pabrik",
                              readOnly: true,
                              onTap: controller.factoryPage,
                              controller: controller.factoryController,
                              suffixIcon:
                                  const AppSuffixIcon(svg: svgDotsHorizontal),
                              validator: (v) => emptyValidator("pabrik", v!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Supplier",
                              hintText: "Pilih supplier",
                              readOnly: true,
                              onTap: controller.supplierPage,
                              controller: controller.supplierController,
                              suffixIcon:
                                  const AppSuffixIcon(svg: svgDotsHorizontal),
                              validator: (v) => emptyValidator("Supplier", v!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Obx(
                              () => AppAddMultiUnitForm(
                                unitController: controller.satuanController,
                                unitPage: controller.satuanPage,
                                buyController: controller.buyController,
                                onBuyChanged: controller.onBuyPriceChanged,
                                percentageFrom: controller.buyPrice.value,
                                retailPrice: controller.retailPrice,
                                retailController: controller.retailController,
                                onRetailChanged: controller.onBuyRetailChanged,
                                partaiPrice: controller.partaiPrice,
                                partaiController: controller.partaiController,
                                onPartaiChanged: controller.onBuyPartaiChanged,
                                cabangPrice: controller.cabangPrice,
                                cabangController: controller.cabangController,
                                onCabangChanged: controller.onBuyCabangChanged,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Stok",
                              hintText: "Masukan stok",
                              numberOnly: true,
                              textInputAction: TextInputAction.next,
                              controller: controller.stokController,
                              validator: (v) => emptyValidator("Stok", v!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Stok Min",
                              hintText: "Masukan stok min",
                              numberOnly: true,
                              controller: controller.stokMinController,
                              validator: (v) => emptyValidator("Stok min", v!),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppFixedBottomBtn(
            onPressed: controller.onSave,
            child: const Text("Simpan", style: AppTheme.btnStyle),
          )
        ],
      ),
    );
  }

  Widget? getCodeSuffixIcon() {
    if (!controller.hasBarcode.value) {
      if (controller.isGetCode.value) {
        return const AppSuffixIcon(
          suffix: SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      } else {
        return null;
      }
    } else {
      return AppSuffixIcon(onTap: controller.clearBarcode);
    }
  }
}
