import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/screens/location/location_provider.dart';
import 'package:provider/provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Center(
      child: locationProvider.weather == null
          ? const CircularProgressIndicator(
              color: MyColors.whiteColor,
            )
          : Text(
              '${locationProvider.weather!.temperature} °C',
              style: const TextStyle(
                color: MyColors.whiteColor,
                fontSize: 22,
              ),
            ),
    );
  }
}
