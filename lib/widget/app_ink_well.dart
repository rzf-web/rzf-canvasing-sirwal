import 'package:flutter/material.dart';

class AppInkWell extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Function()? onTap;
  final Widget? child;
  const AppInkWell({super.key, this.borderRadius, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
