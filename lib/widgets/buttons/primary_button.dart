import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';

class MyPrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  const MyPrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(context).primaryColor, // Explicitly use primaryColor
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),

        // style: ButtonStyle(
        //   shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        //     RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //   ),
        // ),
        child: Text(
          title,
          style: const TextStyle(
            color: MyColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
