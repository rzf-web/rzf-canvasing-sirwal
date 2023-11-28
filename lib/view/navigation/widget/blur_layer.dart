import 'dart:ui';
import 'package:flutter/material.dart';

class BlurLayer extends StatelessWidget {
  final double height;
  final double width;
  final bool show;
  final Function()? onEnd;
  const BlurLayer({
    super.key,
    required this.height,
    required this.width,
    required this.show,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: show ? 2.0 : 0.0,
              sigmaY: show ? 2.0 : 0.0,
            ),
            child: Container(),
          ),
          AnimatedOpacity(
            opacity: show ? 0.1 : 0,
            onEnd: onEnd,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color: Colors.white,
              curve: Curves.easeIn,
            ),
          ),
        ],
      ),
    );
  }
}
