import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';

class PlantsDetailPage extends StatelessWidget {
  final Map<String, dynamic> plant;

  const PlantsDetailPage({required this.plant, super.key});

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
        // title: Text(plant['name']!),
        title: const Text(
          "Details",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display plant image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                plant['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250, // Image size
              ),
            ),
            const SizedBox(height: 20),
            // Display plant name
            Text(
              plant['name']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Container for Soil Type
            _buildInfoContainer(
              icon: Icons.grass,
              label: 'Soil Type',
              value: plant['soilType'],
            ),
            const SizedBox(height: 10),

            // Container for Temperature
            _buildInfoContainer(
              icon: Icons.thermostat,
              label: 'Temperature',
              value: plant['temperature'],
            ),
            const SizedBox(height: 10),

            // Container for Weather Condition
            _buildInfoContainer(
              icon: Icons.wb_sunny,
              label: 'Weather Condition',
              value: plant['weatherCondition'],
            ),
            const SizedBox(height: 20),
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
