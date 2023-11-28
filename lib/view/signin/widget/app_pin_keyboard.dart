import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppPinKeyboard extends StatelessWidget {
  final Function(int) onChanged;
  const AppPinKeyboard({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.borderColor,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: AppRemoveOverscroll(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 0,
            childAspectRatio: 2 / 1,
          ),
          itemBuilder: (context, index) {
            var number = index + 1;
            return GestureDetector(
              onTap: () => onChanged(number),
              child: Container(
                color: Colors.white,
                child: Center(
                  child: number == 12
                      ? const AppSvgIcon(svg: svgTagCross, size: 24)
                      : textWidget(number),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Text textWidget(int number) {
    var num = number;
    if (number == 11) {
      num = 0;
    }
    return Text(
      number == 10 ? "" : (num).toString(),
      style: const TextStyle(
        fontSize: 20,
        color: AppTheme.titleColor,
      ),
    );
  }
}
