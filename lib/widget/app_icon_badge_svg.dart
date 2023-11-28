import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppIconBadge extends StatelessWidget {
  final String svg;
  final int count;
  final Color color;
  final Color badgeColor;
  final double? top;
  final double? right;
  final Function() onTap;

  const AppIconBadge({
    super.key,
    required this.svg,
    required this.count,
    required this.onTap,
    this.badgeColor = Colors.orange,
    this.color = Colors.black,
    this.top,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        color: Colors.transparent,
        child: Stack(
          children: [
            Center(child: AppSvgIcon(svg: svg, size: 24, color: color)),
            if (count != 0)
              Positioned(
                top: top ?? 3,
                right: right ?? 3,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                  ),
                  child: FittedBox(
                    child: Center(
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
