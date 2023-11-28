import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class AppAddUnitFormDialog extends StatelessWidget {
  final Function(String, int) onSave;
  const AppAddUnitFormDialog({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final unitController = TextEditingController();
    final isiController = TextEditingController();
    return AppRemoveOverscroll(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
              ),
              child: const Text(
                "Tambah Satuan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.titleColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.mobilePadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: AppTextFieldInput(
                      label: "Satuan",
                      hintText: "Tambah Satuan",
                      controller: unitController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: AppTextFieldInput(
                      label: "Isi",
                      hintText: "0",
                      numberOnly: true,
                      controller: isiController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
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
                            onPressed: () {
                              if (unitController.text != "" &&
                                  isiController.text != "") {
                                onSave(
                                  unitController.text,
                                  int.parse(isiController.text),
                                );
                                Get.back();
                              }
                            },
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
          ],
        ),
      ),
    );
  }
}
