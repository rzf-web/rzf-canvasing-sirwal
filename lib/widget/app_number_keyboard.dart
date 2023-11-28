import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppNumKeyboard extends StatefulWidget {
  final int initial;
  final Function(int) onChanged;
  const AppNumKeyboard({
    super.key,
    required this.onChanged,
    this.initial = 0,
  });

  @override
  State<AppNumKeyboard> createState() => _AppNumKeyboardState();
}

class _AppNumKeyboardState extends State<AppNumKeyboard> {
  var result = 0;
  Timer? timer;

  onChanged(int number) {
    var tmpStr = result.toString();
    if (number <= 11) {
      if (result == 0.0 && number <= 9) {
        result += number;
      } else {
        var num = number.toString();
        if (number == 10) {
          num = "0";
        } else if (number == 11) {
          num = "000";
        }
        tmpStr += num;
        result = int.parse(tmpStr);
      }
    } else if (tmpStr.length != 1) {
      tmpStr = tmpStr.substring(0, tmpStr.length - 1);
      result = int.parse(tmpStr);
    } else {
      result = 0;
    }
    widget.onChanged(result);
  }

  initResult() {
    result = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    initResult();
    return Container(
      color: AppTheme.borderColor,
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
              onLongPress: () {
                timer = Timer.periodic(
                  const Duration(milliseconds: 50),
                  (timer) {
                    onChanged(number);
                  },
                );
              },
              onLongPressEnd: (_) => setState(() {
                timer?.cancel();
              }),
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
    if (number == 10) {
      num = 0;
    }
    return Text(
      number == 11 ? "000" : (num).toString(),
      style: const TextStyle(
        fontSize: 20,
        color: AppTheme.titleColor,
      ),
    );
  }
}
