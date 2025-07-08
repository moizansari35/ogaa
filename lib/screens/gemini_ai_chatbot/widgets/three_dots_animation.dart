import 'package:flutter/material.dart';

class ThreeDotsAnimation extends StatelessWidget {
  const ThreeDotsAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _dot(0),
          const SizedBox(width: 5),
          _dot(1),
          const SizedBox(width: 5),
          _dot(2),
        ],
      ),
    );
  }

  Widget _dot(int index) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 500 + (index * 200)),
      curve: Curves.easeInOut,
      child: Container(
        height: 10,
        width: 10,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
