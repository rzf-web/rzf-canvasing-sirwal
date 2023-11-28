import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/validatior.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.controller.update.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class SupplierUpdatePage extends GetView<SupplierUpdateController> {
  const SupplierUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: AppCustomAppBar(
        title: "${controller.data != null ? "Edit" : "Tambah"} Data Supplier",
      ),
      body: Column(
        children: [
          Expanded(
            child: AppRemoveOverscroll(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Nama Supplier",
                            hintText: "Masukan nama supplier",
                            controller: controller.nameController,
                            validator: (v) => emptyValidator("Nama", v!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            numberOnly: true,
                            label: "No Telepon/WA",
                            hintText: "Masukan telepon",
                            controller: controller.phoneController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            numberOnly: true,
                            label: "kontak",
                            hintText: "Masukan kontak",
                            controller: controller.contactController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            numberOnly: true,
                            label: "Rekening",
                            hintText: "Masukan rekening",
                            controller: controller.rekController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Alamat Lengkap",
                            hintText: "Nama Desa, Jalan dan Lainya",
                            controller: controller.addressController,
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
          Obx(
            () => AppFixedBottomBtn(
              text: "${controller.data != null ? "Update" : "Simpan"} Data",
              isLoading: controller.isLoading.value,
              onPressed: controller.onSave,
            ),
          ),
        ],
      ),
    );
  }
}
