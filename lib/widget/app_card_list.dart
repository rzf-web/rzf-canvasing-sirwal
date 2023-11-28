import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppCardList extends StatelessWidget {
  final bool isLast;
  final double marginPadding;
  final Widget child;
  const AppCardList({
    super.key,
    required this.child,
    required this.isLast,
    this.marginPadding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: marginPadding, bottom: marginPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : AppTheme.borderColor,
          ),
        ),
      ),
      child: child,
    );
  }
}
