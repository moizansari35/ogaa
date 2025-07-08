import 'package:flutter/cupertino.dart';
import 'package:ogaa/constants/colors.dart';

Container userPrompt({
  required final bool isPrompt,
  required String message,
  required String time,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
      left: isPrompt ? 80 : 15,
      right: isPrompt ? 15 : 80,
    ),
    decoration: BoxDecoration(
      color: isPrompt ? MyColors.primaryColor : MyColors.greyColor,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomRight: isPrompt ? const Radius.circular(20) : Radius.zero,
        bottomLeft: isPrompt ? Radius.zero : const Radius.circular(20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: TextStyle(
            fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
            fontSize: 18,
            color: isPrompt ? MyColors.whiteColor : MyColors.blackColor,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 14,
            color: isPrompt ? MyColors.whiteColor : MyColors.blackColor,
          ),
        ),
      ],
    ),
  );
}
