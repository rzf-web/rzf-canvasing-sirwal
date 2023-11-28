import 'package:flutter/material.dart';

class AppKeyValueItem extends StatelessWidget {
  final String keyItem;
  final String value;
  final EdgeInsetsGeometry padding;

  const AppKeyValueItem({
    Key? key,
    required this.keyItem,
    required this.value,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey.shade800),
                  child: Text(keyItem),
                ),
              ),
              const Text(' : '),
              Expanded(flex: 2, child: Text(value)),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
