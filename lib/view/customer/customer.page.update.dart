import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/validatior.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.controller.update.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_clear_suffix_icon.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down_search.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class CustomerUpdatePage extends GetView<CustomerUpdateController> {
  const CustomerUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: AppCustomAppBar(
        title: "${controller.data != null ? "Edit" : "Tambah"} Data Pelanggan",
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
                            label: "Nama Pelanggan",
                            hintText: "Masukan nama pelanggan",
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
                            validator: (v) => phoneValidator("No. Telp", v!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppDropDownSearch(
                            label: "Provinsi",
                            hintText: "Pilih Provinsi",
                            validator: (v) => emptyValidator("Provinsi", v!),
                            controller: controller.provinceController,
                            data: const [],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppDropDownSearch(
                            label: "Kota",
                            hintText: "Pilih Kota",
                            validator: (v) => emptyValidator("Kota", v!),
                            controller: controller.cityController,
                            data: const [],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppDropDownSearch(
                            label: "Kabupaten",
                            hintText: "Pilih Kabupaten",
                            validator: (v) => emptyValidator("Kabupaten", v!),
                            controller: controller.kabController,
                            data: const [],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Alamat Lengkap",
                            hintText: "Nama Desa, Jalan dan Lainya",
                            controller: controller.addressController,
                            validator: (v) => emptyValidator("Alamat", v!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Map",
                            hintText: "Cari map",
                            readOnly: true,
                            controller: controller.mapController,
                            validator: (v) => emptyValidator("Map", v!),
                            suffixIcon: SizedBox(
                              width: 92,
                              child: AppButton(
                                borderRadius: 4.0,
                                onPressed: controller.onMapPick,
                                child: const Text(
                                  "Cari",
                                  style: AppTheme.btnStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Obx(
                            () => AppTextFieldInput(
                              label: "Photo",
                              hintText: "Upload photo",
                              readOnly: true,
                              controller: controller.photoController,
                              onTap: () => controller.onPickImage(context),
                              validator: (v) => emptyValidator("Photo", v!),
                              suffixIcon: controller.photos().isEmpty
                                  ? null
                                  : AppSuffixIcon(
                                      onTap: controller.onClearPhoto),
                            ),
                          ),
                        ),
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppFixedBottomBtn(
            text: "${controller.data != null ? "Update" : "Simpan"} Data",
            onPressed: controller.onSave,
          ),
        ],
      ),
    );
  }
}
