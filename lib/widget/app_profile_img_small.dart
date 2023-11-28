import 'package:flutter/material.dart';

class AppProfileImgSmall extends StatelessWidget {
  final String img;
  const AppProfileImgSmall({
    super.key,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
