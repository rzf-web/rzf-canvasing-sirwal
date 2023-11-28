import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'app_ink_well.dart';

class AppSvgIconBtn extends StatelessWidget {
  final String svg;
  final double size;
  final Color color;
  final Function()? onTap;
  const AppSvgIconBtn({
    super.key,
    required this.svg,
    this.size = 24,
    this.color = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              svg,
              height: size,
              width: size,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
          AppInkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
