import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/validatior.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_clear_suffix_icon.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class AppAddMultiUnitForm extends StatelessWidget {
  //Satuan

  final TextEditingController? unitController;
  final Function() unitPage;
  //isi Satuan
  final TextEditingController? isiController;
  //Buy Price
  final bool buyReadOnly;
  final TextEditingController buyController;
  final Function(double)? onBuyChanged;
  //percentageFrom
  final double percentageFrom;
  //Retail Price
  final double retailPrice;
  final TextEditingController retailController;
  final Function(double)? onRetailChanged;
  //Partai Price
  final double partaiPrice;
  final TextEditingController partaiController;
  final Function(double)? onPartaiChanged;
  //Partai Price
  final double cabangPrice;
  final TextEditingController cabangController;
  final Function(double)? onCabangChanged;
  //action
  final Function()? onTap;
  final bool isProductUnit;
  const AppAddMultiUnitForm({
    super.key,
    this.unitController,
    required this.unitPage,
    this.isiController,
    this.buyReadOnly = false,
    required this.buyController,
    required this.onBuyChanged,
    required this.percentageFrom,
    required this.retailPrice,
    required this.retailController,
    required this.onRetailChanged,
    required this.partaiPrice,
    required this.partaiController,
    required this.onPartaiChanged,
    required this.cabangPrice,
    required this.cabangController,
    required this.onCabangChanged,
    this.onTap,
    this.isProductUnit = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppRemoveOverscroll(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isProductUnit) const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppTextFieldInput(
                label: "Satuan",
                hintText: "Pilih satuan",
                readOnly: true,
                onTap: unitPage,
                controller: unitController,
                suffixIcon: const AppSuffixIcon(svg: svgDotsHorizontal),
                validator: (v) => emptyValidator("Satuan", v!),
              ),
            ),
            if (isProductUnit)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AppTextFieldInput(
                  label: "Jumlah Isi",
                  hintText: "Masukan isi",
                  numberOnly: true,
                  textInputAction: TextInputAction.next,
                  controller: isiController,
                  validator: (v) => emptyValidator("Jumlah Isi", v!),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppTextFieldInput(
                label: "Harga Beli",
                hintText: "0",
                isCurrency: true,
                readOnly: buyReadOnly,
                controller: buyController,
                onCurrencyChanged: onBuyChanged,
                validator: (v) => emptyValidator("Harga Beli", v!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppTextFieldInput(
                label: "Harga Retail",
                hintText: "0",
                isCurrency: true,
                withCurrencyPercentage: true,
                percentageFrom: percentageFrom,
                controller: retailController,
                initialCurrency: retailPrice,
                onCurrencyChanged: onRetailChanged,
                validator: (v) => emptyValidator("Harga Retail", v!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppTextFieldInput(
                label: "Harga Partai",
                hintText: "0",
                isCurrency: true,
                withCurrencyPercentage: true,
                percentageFrom: percentageFrom,
                initialCurrency: partaiPrice,
                controller: partaiController,
                onCurrencyChanged: onPartaiChanged,
                validator: (v) => emptyValidator("Harga Partai", v!),
              ),
            ),
            AppTextFieldInput(
              label: "Harga Cabang",
              hintText: "0",
              isCurrency: true,
              withCurrencyPercentage: true,
              percentageFrom: percentageFrom,
              controller: cabangController,
              initialCurrency: cabangPrice,
              onCurrencyChanged: onCabangChanged,
              validator: (v) => emptyValidator("Harga Cabang", v!),
            ),
            if (isProductUnit)
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: () => Get.back(),
                        color: const Color(0xFFD5D8E2),
                        child: Text(
                          "Batal",
                          style: AppTheme.btnStyle.copyWith(
                            color: AppTheme.titleColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        onPressed: onTap ?? () {},
                        child: Text(
                          "Simpan",
                          style: AppTheme.btnStyle.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
