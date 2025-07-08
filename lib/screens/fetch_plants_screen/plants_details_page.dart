import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/models/plant_model/plant_model.dart';

class PlantsDetailPageFirebase extends StatelessWidget {
  final PlantModel plant;

  const PlantsDetailPageFirebase({required this.plant, super.key});

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
          ),
        ),
        title: const Text(
          "Details",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display plant image from Firebase
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: plant.imageUrl, // Fetch the image URL from Firebase
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250, // Image size
                // loadingBuilder: (context, child, loadingProgress) {
                //   if (loadingProgress == null) return child;
                //   return Center(
                //     child: CircularProgressIndicator(
                //       value: loadingProgress.expectedTotalBytes != null
                //           ? loadingProgress.cumulativeBytesLoaded /
                //               loadingProgress.expectedTotalBytes!
                //           : null,
                //       color: MyColors.primaryColor,
                //     ),
                //   );
                // },
                // errorBuilder: (context, error, stackTrace) =>
                //     const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 20),

            // Display plant name
            Text(
              plant.name, // Use a default value if null
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Display plant description
            Text(
              plant.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Container for Soil Type
            _buildInfoContainer(
              icon: Icons.grass,
              label: 'Soil Type',
              value: plant.soilType,
            ),
            const SizedBox(height: 10),

            // Container for Temperature
            _buildInfoContainer(
              icon: Icons.thermostat,
              label: 'Temperature',
              value:
                  '${plant.minTemp.round().toString()}°C - ${plant.maxTemp.round().toString()}°C',
            ),
            const SizedBox(height: 10),

            // Container for Weather Condition
            _buildInfoContainer(
              icon: Icons.wb_sunny,
              label: 'Weather Condition',
              value: (plant.weatherType as List<dynamic>?)?.join(', ') ??
                  'N/A', // Convert list to a comma-separated string
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build the information container with icon and text
  Widget _buildInfoContainer({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50], // Light background color
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: MyColors.primaryColor, // Border color
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: MyColors.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.blackColor,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
