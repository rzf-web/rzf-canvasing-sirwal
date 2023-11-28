import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';

class AppListTile extends StatelessWidget {
  final String title;
  final bool isLast;
  final Widget? leading;
  final Widget? trailing;
  final Function() onTap;
  final Function()? onLongPress;
  const AppListTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    required this.isLast,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AppCardList(
        isLast: isLast,
        marginPadding: 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.titleColor,
                  ),
                ),
              ),
            ),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
