import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/validatior.dart';
import 'package:rzf_canvasing_sirwal/model/cashflow.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.controller.update.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/widget/app_cashflow_tabbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class CashFlowUpdatePage extends GetView<CashFlowUpdateController> {
  const CashFlowUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: AppCustomAppBar(
        title:
            "${controller.data != null && controller.data is CashFlow ? "Edit" : "Tambah"} Cash Flow",
        showBorder: false,
      ),
      body: Column(
        children: [
          AppCashFlowTabbar(
            tabBars: const ['Pemasukan', 'Pengeluaran'],
            controller: controller.tabController,
          ),
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
                            label: "Tanggal",
                            hintText: "Pilih tanggal",
                            readOnly: true,
                            onTap: controller.pickDate,
                            controller: controller.dateController,
                            validator: (v) => emptyValidator("Tanggal", v!),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 16.0),
                        //   child: AppTextFieldInput(
                        //     label: "Akun",
                        //     hintText: "Masukan akun",
                        //     controller: controller.accountController,
                        //     readOnly: true,
                        //     onTap: controller.pickAccount,
                        //     validator: (v) => emptyValidator("Akun", v!),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Kategori",
                            hintText: "Masukan kategori",
                            controller: controller.categoryController,
                            readOnly: true,
                            onTap: controller.pickCategory,
                            validator: (v) => emptyValidator("Kategori", v!),
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
                            controller: controller.jumlahController,
                            onCurrencyChanged: controller.onCurrencyChanged,
                            validator: (v) => emptyValidator("Jumlah", v!),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 16.0),
                        //   child: Obx(
                        //     () => AppDropDown(
                        //       label: "Akun",
                        //       hintText: "Pilih akun",
                        //       value: controller.account.value == ''
                        //           ? null
                        //           : controller.account.value,
                        //       items: controller.accounts,
                        //       onChanged: (v) => controller.account.value = v!,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 16.0),
                        //   child: Obx(
                        //     () => AppDropDown(
                        //       label: "Category",
                        //       hintText: "Pilih category",
                        //       value: controller.category.value == ''
                        //           ? null
                        //           : controller.category.value,
                        //       items: controller.categories,
                        //       onChanged: (v) => controller.category.value = v!,
                        //     ),
                        //   ),
                        // ),
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
}
