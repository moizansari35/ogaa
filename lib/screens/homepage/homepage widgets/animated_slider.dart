import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/sized_box.dart';

class HomeAnimatedSlider extends StatelessWidget {
  final List<String> flyers = [
    'assets/images/flyer1.jpg',
    'assets/images/flyer2.jpg',
    'assets/images/flyer3.jpg',
    'assets/images/flyer4.jpg',
    'assets/images/flyer5.jpg',
    'assets/images/flyer6.jpg',
  ];

  HomeAnimatedSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: context.screenHeight,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              // Handle page change if needed
            },
          ),
          items: flyers.map((flyer) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      flyer,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
