import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 480) {
          return mobileBody;
        } else {
          return tabletBody;
        }
      },
    );
  }
}

class OrientationLayout extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;
  const OrientationLayout({
    super.key,
    required this.portrait,
    required this.landscape,
  });

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return portrait;
    } else {
      return landscape;
    }
  }
}
