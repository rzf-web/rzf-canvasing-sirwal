import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.controller.detail.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_detail_label_content.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class CustomerDetailPage extends GetView<CustomerDetailController> {
  const CustomerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: const AppCustomAppBar(title: "Detail Data Pelanggan"),
      body: Column(
        children: [
          Expanded(
            child: AppRemoveOverscroll(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      AppDetailLabelContent(
                        label: "ID Pelanggan",
                        content: controller.data.id!,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      AppDetailLabelContent(
                        label: "Nama pelanggan",
                        content: controller.data.name,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      AppDetailLabelContent(
                        label: "No. Telepon",
                        content: controller.data.phone,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      AppDetailLabelContent(
                        label: "No. Polisi",
                        content: controller.data.noPolice,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      AppDetailLabelContent(
                        label: "Merk/Type",
                        content: controller.data.merk,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      AppDetailLabelContent(
                        label: "Jenis/Model",
                        content: controller.data.model,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      AppDetailLabelContent(
                        label: "Alamat",
                        content: controller.data.alamat,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      const SizedBox(height: 20),
                    ],
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
