import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppCustomerViewPhotos extends StatelessWidget {
  final List<String> links;
  const AppCustomerViewPhotos({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...links.map(
              (e) => Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: AppTheme.secBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(e, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
