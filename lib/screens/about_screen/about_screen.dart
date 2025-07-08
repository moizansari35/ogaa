// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ogaa/constants/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.blackColor,
          ),
        ),
        title: Text(
          "About OGAA",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.primaryColor.withOpacity(0.1), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Organic Gardening Assistant Application",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: MyColors.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Purpose",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: MyColors.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Assist users in choosing and learning about plants suitable for their climate and region.",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: MyColors.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Features",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: MyColors.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const FeatureItem(
                  icon: Icons.offline_pin,
                  text:
                      "Access detailed information on a wide range of plants offline.",
                ),
                const FeatureItem(
                  icon: Icons.location_on,
                  text:
                      "Enter your location and current climate temperature for personalized plant recommendations.",
                ),
                const FeatureItem(
                  icon: Icons.navigation,
                  text: "User-friendly navigation and intuitive interface.",
                ),
                const FeatureItem(
                  icon: Icons.lightbulb,
                  text:
                      "Expert gardening tips to enhance your plant care skills.",
                ),
                const FeatureItem(
                  icon: Icons.update,
                  text:
                      "Regular updates with new plant entries and gardening insights.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: MyColors.primaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: MyColors.blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
