import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/helper/validatior.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/mutasi_kas/mutasi_kas.controller.update.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class MutasiKasUpdatePage extends GetView<MutasiKasUpdateController> {
  const MutasiKasUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;

    return Scaffold(
      appBar: AppCustomAppBar(
        title: "${controller.data != null ? "Edit" : "Tambah"} Mutasi kas",
        actions: [
          if (controller.data != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: AppSvgIconBtn(
                size: 20,
                svg: svgTrash,
                color: Colors.red,
                onTap: controller.onDeleteMutation,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AppRemoveOverscroll(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Tanggal",
                            hintText: "Pilih tanggal",
                            readOnly: true,
                            onTap: controller.pickDate,
                            controller: controller.dateController,
                            validator: (v) => emptyValidator("Tanggal", v!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextFieldInput(
                                  label: "Sumber",
                                  hintText: "Pilih sumber",
                                  controller: controller.sourceController,
                                  readOnly: true,
                                  onTap: () => controller.pickAccount(true),
                                  validator: (v) =>
                                      emptyValidator("Sumber", v!),
                                ),
                                if (controller.source.value != null)
                                  textFieldNote(
                                      "Jumlah: ${moneyFormatter(controller.source.value!.saldo)}")
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextFieldInput(
                                  label: "Tujuan",
                                  hintText: "Pilih tujuan",
                                  controller: controller.destinationController,
                                  readOnly: true,
                                  onTap: () => controller.pickAccount(false),
                                  validator: (v) =>
                                      emptyValidator("Tujuan", v!),
                                ),
                                if (controller.destination.value != null)
                                  textFieldNote(
                                      "Jumlah: ${moneyFormatter(controller.destination.value!.saldo)}")
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Keterangan",
                            hintText: "Masukan keterangan",
                            controller: controller.noteController,
                            validator: (v) => emptyValidator("Keterangan", v!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Jumlah",
                            hintText: "Rp",
                            isCurrency: true,
                            controller: controller.nominalController,
                            onCurrencyChanged: controller.onCurrencyChanged,
                            validator: (v) => emptyValidator("Jumlah", v!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppFixedBottomBtn(
            onPressed: controller.onSave,
            child: const Text("Simpan", style: AppTheme.btnStyle),
          ),
        ],
      ),
    );
  }

  Widget textFieldNote(String message) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.capColor,
        ),
      ),
    );
  }
}
