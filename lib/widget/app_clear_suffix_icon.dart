import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppSuffixIcon extends StatelessWidget {
  final String? svg;
  final Widget? suffix;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  const AppSuffixIcon({
    super.key,
    this.onTap,
    this.padding,
    this.suffix,
    this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10,
        height: 10,
        color: Colors.transparent,
        child: Stack(
          children: [
            Padding(
              padding: padding ?? const EdgeInsets.only(right: 16.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: suffix ?? suffixIcon()),
            ),
          ],
        ),
      ),
    );
  }

  Widget suffixIcon() {
    if (svg == null) {
      return Opacity(
        opacity: .5,
        child: SvgPicture.asset(svgCloseCircle),
      );
    } else {
      return AppSvgIcon(svg: svg!, size: 24, color: AppTheme.capColor);
    }
  }
}
