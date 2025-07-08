import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:provider/provider.dart';

import 'location_provider.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Center(
      child: locationProvider.weather == null
          ? Text(
              locationProvider.city,
              style: const TextStyle(
                color: MyColors.whiteColor,
                fontSize: 20,
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locationProvider.city,
                  style: const TextStyle(
                    color: MyColors.whiteColor,
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 10),
                // Text(
                //   'Temperature: ${locationProvider.weather!.temperature}°C',
                //   style: const TextStyle(
                //     color: MyColors.whiteColor,
                //     fontSize: 18,
                //   ),
                // ),
              ],
            ),
    );
  }
}
