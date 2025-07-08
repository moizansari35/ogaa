import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/sized_box.dart';

class HomeRow extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;
  const HomeRow({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          text1,
          style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        100.width,
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: const TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
