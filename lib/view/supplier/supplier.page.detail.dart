import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.controller.detail.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_detail_label_content.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class SupplierDetailPage extends GetView<SupplierDetailController> {
  const SupplierDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: const AppCustomAppBar(
        title: "Detail Data Supplier",
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 4.0),
          //   child: AppSvgIconBtn(
          //     svg: svgTrash,
          //     color: Colors.red,
          //     onTap: controller.onRemove,
          //   ),
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AppRemoveOverscroll(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Obx(
                    () => Column(
                      children: [
                        const SizedBox(height: 20),
                        AppDetailLabelContent(
                          label: "ID Supplier",
                          content: controller.data.value.id!,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        AppDetailLabelContent(
                          label: "Nama Supplier",
                          content: controller.data.value.name,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        AppDetailLabelContent(
                          label: "No. Telepon",
                          content: controller.data.value.phone,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        AppDetailLabelContent(
                          label: "Kontak",
                          content: controller.data.value.contact,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        AppDetailLabelContent(
                          label: "Rekening",
                          content: controller.data.value.rekening,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        AppDetailLabelContent(
                          label: "Alamat",
                          content: controller.data.value.address,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // AppFixedBottomBtn(
          //   text: "Edit Data",
          //   onPressed: controller.onEditData,
          // ),
        ],
      ),
    );
  }
}
