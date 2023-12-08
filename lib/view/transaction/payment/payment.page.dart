import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/sale_type.enum.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/payment/payment.controller.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_payment_suggestion.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down_search.dart';
import 'package:rzf_canvasing_sirwal/widget/app_fixed_bottom_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon_btn.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    var label = "Nama ${controller.type.isBuy ? "Supplier" : "Pelanggan"}";
    var hint = "Pilih ${controller.type.isBuy ? "supplier" : "pelanggan"}";
    return WillPopScope(
      onWillPop: controller.onWillPopScope,
      child: Scaffold(
        appBar: AppCustomAppBar(
          title: "Pembayaran",
          onLeadingTap: controller.getBack,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: AppSvgIconBtn(
                svg: svgQrcode,
                onTap: () {
                  controller.getBack();
                  Get.back();
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: AppRemoveOverscroll(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Obx(
                    () => ListView(
                      children: [
                        const SizedBox(height: padding),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: formPickPerson(label, hint),
                        ),
                        if (controller.type.isBuy)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Faktur",
                              hintText: "Masukan faktur",
                              controller: controller.fakturController,
                            ),
                          ),
                        if (controller.type.isSale)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Obx(
                              () => AppDropDownSearch(
                                label: "Sales",
                                hintText: "Pilih Sales",
                                isLoading: controller.salesLoading.value,
                                controller: controller.salesController,
                                data: controller.salesList(),
                              ),
                            ),
                          ),
                        if (controller.type.isSale)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Obx(
                              () => AppDropDown(
                                label: "Jenis Jual",
                                hintText: "Pilih jenis jual",
                                value: controller.saleType.value,
                                items: SaleType.values
                                    .map((e) => e.name.capitalize!)
                                    .toList(),
                                onChanged: (v) =>
                                    controller.saleType.value = v!,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Akun",
                            hintText: "Pilih akun",
                            readOnly: true,
                            onTap: controller.accountPage,
                            controller: controller.accountController,
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppDropDown(
                              label: "Jenis Pembayaran",
                              hintText: "Pilih jenis pembayaran",
                              items: controller.paymentTypes,
                              value: controller.paymentType.value,
                              onChanged: (v) =>
                                  controller.paymentType.value = v!,
                            ),
                          ),
                        ),
                        if (controller.paymentType.value != "Tunai")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Tanggal",
                              hintText: "Pilih tanggal",
                              readOnly: true,
                              onTap: controller.pickDate,
                              controller: controller.dateController,
                            ),
                          ),
                        if (controller.paymentType.value != "Tunai")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AppTextFieldInput(
                              label: "Tanggal Tempo",
                              hintText: "Pilih tanggal tempo",
                              readOnly: true,
                              onTap: controller.pickDate,
                              controller: controller.tempoController,
                            ),
                          ),
                        if (controller.type.isSale)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: AppTextFieldInput(
                                  label: "Diskon Penjualan",
                                  hintText: "0",
                                  isCurrency: true,
                                  controller: controller.discountController,
                                  onCurrencyChanged:
                                      controller.discountOnChanged,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: AppTextFieldInput(
                                  label: "Total Penjualan",
                                  hintText: "0",
                                  readOnly: true,
                                  readOnlyDifColor: true,
                                  controller: controller.totalController,
                                ),
                              ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppTextFieldInput(
                            label: "Total Pembayaran",
                            hintText: "0",
                            readOnly: true,
                            readOnlyDifColor: true,
                            controller: controller.grandTotalController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: AppTextFieldInput(
                            label: "Bayar",
                            hintText: "0",
                            readOnly: true,
                            controller: controller.payController,
                          ),
                        ),
                        Obx(
                          () => AppPaymentSuggestion(
                            moneySuggestion: controller.moneySuggestion(),
                            onSuggestionTap: controller.pickSuggestion,
                          ),
                        ),
                        const SizedBox(height: padding),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AppFixedBottomBtn(
              onPressed: controller.onSave,
              child: const Text(
                "Simpan",
                style: AppTheme.btnStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formPickPerson(String label, String hint) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: AppTextFieldInput(
            label: label,
            hintText: hint,
            readOnly: true,
            controller: controller.personController,
            onTap: controller.type.isBuy ? controller.personPage : null,
          ),
        ),
        if (controller.type.isSale)
          Container(
            height: 47,
            width: 47,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppTheme.textFieldBorderColor),
              color: Colors.transparent,
            ),
            child: Center(
              child: Text(
                controller.point.value.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
