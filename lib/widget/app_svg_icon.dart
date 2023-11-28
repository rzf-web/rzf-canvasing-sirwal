import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSvgIcon extends StatelessWidget {
  final String svg;
  final double size;
  final Color color;
  const AppSvgIcon({
    super.key,
    required this.svg,
    required this.size,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      height: size,
      width: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
