import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart'; // Assuming MyColors is stored here
import 'package:ogaa/constants/routes/routes.dart';
import 'package:ogaa/models/plant_model/plant_model.dart';
import 'package:ogaa/screens/fetch_plants_screen/plants_details_page.dart';

class PlantCard extends StatelessWidget {
  final PlantModel plant;

  const PlantCard({required this.plant, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to details page if needed
        Routes.routesInstance.push(
            widget: PlantsDetailPageFirebase(plant: plant), context: context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: MyColors.primaryColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 12,
              offset: const Offset(0, 6), // Drop shadow effect
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant image with rounded corners and shadow
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: plant.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Plant name with bold font
            Text(
              plant.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor, // Your primary color for emphasis
              ),
            ),
            const SizedBox(height: 8),
            // Category and Weather info with a smaller, regular font
            Text(
              'Category: ${plant.categoryType.join(', ')}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Weather: ${plant.weatherType.join(', ')}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            // Temperature range with a green color for emphasis
            Text(
              'Temperature: ${plant.minTemp.round()} - ${plant.maxTemp.round()} °C',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            // Soil Type and Description with subtle separation
            Row(
              children: [
                const Icon(
                  Icons.grass,
                  color: MyColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Soil Type: ${plant.soilType}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${plant.description}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis, // Limits text and adds "..."
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
