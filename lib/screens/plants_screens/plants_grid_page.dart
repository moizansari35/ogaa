import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/screens/plants_screens/plants_gridview.dart'; // Import the PlantGrid widget

class PlantsGridPage extends StatelessWidget {
  final List<Map<String, dynamic>> allPlants;

  const PlantsGridPage({super.key, required this.allPlants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.whiteColor),
        title: const Text(
          "All Plants",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.whiteColor,
          ),
        ),
        centerTitle: true,

        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //   ),
        // ),
        backgroundColor: MyColors.primaryColor,
      ),
      body: PlantGrid(
        plants: allPlants,
      ), // Reuse your existing PlantGrid widget
    );
  }
}
