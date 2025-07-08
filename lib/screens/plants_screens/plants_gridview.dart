import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/routes/routes.dart';
import 'package:ogaa/constants/sized_box.dart';
import 'package:ogaa/screens/plants_screens/plants_detail_page.dart';

class PlantGrid extends StatelessWidget {
  final List<Map<String, dynamic>> plants;

  const PlantGrid({required this.plants, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, // Aspect ratio of each item (height:width)
      ),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the detailed page and pass the selected plant's data
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PlantsDetailPage(plant: plant),
            //   ),
            // );
            Routes().push(
              widget: PlantsDetailPage(plant: plant),
              context: context,
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                color: MyColors.greyColor,
              ),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display the plant image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.asset(
                    plant['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: context.screenHeight / 5,
                  ),
                ),
                // Display the plant name
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    plant['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
