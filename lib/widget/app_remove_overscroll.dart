import 'package:flutter/material.dart';

class AppRemoveOverscroll extends StatelessWidget {
  final Widget child;
  const AppRemoveOverscroll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: child,
    );
  }
}
