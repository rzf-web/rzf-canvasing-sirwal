import 'package:flutter/material.dart';

class AppLoadingBtn extends StatelessWidget {
  const AppLoadingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: Color(0xFFFFFFFF),
                strokeWidth: 2,
              ),
            ),
          ),
          Text(
            "Loading...",
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ],
      ),
    );
  }
}
