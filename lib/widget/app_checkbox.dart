import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppCheckBox extends StatefulWidget {
  final String? rightText;
  final Function(bool) onChanged;
  const AppCheckBox({super.key, required this.onChanged, this.rightText});

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  var value = false.obs;

  onChanged() {
    var oldValue = value.value;
    value.value = !oldValue;
    widget.onChanged(value.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Obx(
              () => Checkbox(
                activeColor: AppTheme.primaryColor,
                value: value.value,
                onChanged: (_) => onChanged(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          if (widget.rightText != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.rightText!,
                style: const TextStyle(color: AppTheme.titleColor),
              ),
            ),
        ],
      ),
    );
  }
}
