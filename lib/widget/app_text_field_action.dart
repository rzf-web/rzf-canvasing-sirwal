import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down_search.dart';
import 'package:rzf_canvasing_sirwal/widget/app_text_field_input.dart';

class AppTextFieldAction extends StatefulWidget {
  final String label;
  final String hintText;
  final String? dropDownValue;
  final List<dynamic>? menu;
  final bool dropDownFieldSearch;
  final bool dropDownField;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget iconAction;
  final EdgeInsetsGeometry padding;
  final Function() onActionTap;
  final String? Function(String?)? validator;
  final Function(String?)? onDropDownChanged;
  final TextEditingController? controller;
  const AppTextFieldAction({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    required this.iconAction,
    required this.onActionTap,
    required this.padding,
    this.suffixIcon,
    this.dropDownFieldSearch = false,
    this.dropDownField = false,
    this.readOnly = false,
    this.menu,
    this.validator,
    this.dropDownValue,
    this.onDropDownChanged,
  });

  @override
  State<AppTextFieldAction> createState() => _AppTextFieldActionState();
}

class _AppTextFieldActionState extends State<AppTextFieldAction> {
  var isValid = true.obs;

  String? validator(String? value) {
    isValid.value = widget.validator!(value) == null;
    return widget.validator!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Obx(
        () => Row(
          crossAxisAlignment: isValid.value
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.center,
          children: [
            if (widget.dropDownFieldSearch)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AppDropDownSearch(
                    label: widget.label,
                    hintText: widget.hintText,
                    controller: widget.controller,
                    validator: widget.validator != null ? validator : null,
                    data: widget.menu!,
                  ),
                ),
              )
            else if (widget.dropDownField)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AppDropDown(
                    label: widget.label,
                    hintText: widget.hintText,
                    value: widget.dropDownValue!,
                    items: widget.menu as List<String>,
                    onChanged: widget.onDropDownChanged!,
                  ),
                ),
              )
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AppTextFieldInput(
                    label: widget.label,
                    hintText: widget.hintText,
                    controller: widget.controller,
                    readOnly: true,
                    suffixIcon: widget.suffixIcon,
                    validator: widget.validator != null ? validator : null,
                  ),
                ),
              ),
            SizedBox(
              height: 47,
              width: 47,
              child: AppButton(
                borderRadius: 4,
                onPressed: widget.onActionTap,
                color: AppTheme.secBgColor,
                border: Border.all(color: AppTheme.textFieldBorderColor),
                child: widget.iconAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
