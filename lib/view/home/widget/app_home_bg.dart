import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppHomeBg extends StatelessWidget {
  const AppHomeBg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -80,
      top: -60,
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(38),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFFFFF).withOpacity(.6),
              const Color(0xFFFFFFFF).withOpacity(.3),
              const Color(0xFFFFFFFF).withOpacity(.1),
            ],
          ),
        ),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
