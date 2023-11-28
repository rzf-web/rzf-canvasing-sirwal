import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/widget/app_ink_well.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppMenuTile extends StatelessWidget {
  final String svg;
  final double horiPadding;
  final Color color;
  final String title;
  final Function()? onTap;

  const AppMenuTile({
    super.key,
    required this.svg,
    required this.title,
    required this.horiPadding,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: horiPadding,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                color: Colors.transparent,
                height: 20,
                width: 20,
                child: Stack(
                  children: [
                    Center(
                      child: AppSvgIcon(svg: svg, size: 18, color: color),
                    )
                  ],
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
