import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/constants.dart';
import 'package:ogaa/screens/location/location_provider.dart';
import 'package:ogaa/screens/weather/weather_model.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import 'widgets/custom_dropdown.dart';
import 'widgets/plant_card.dart';

class FetchPlantsScreen extends StatefulWidget {
  const FetchPlantsScreen({super.key});

  @override
  FetchPlantsScreenState createState() => FetchPlantsScreenState();
}

class FetchPlantsScreenState extends State<FetchPlantsScreen> {
  String? selectedCategory;
  String? selectedWeather;
  WeatherModel? currentWeather; // Store the live weather data
  bool isWeatherLoading = false; // Loading state for weather fetching
  bool isPlantsLoading = false; // Loading state for plant fetching

  List<String> categoryOptions = ['Indoor', 'Outdoor', 'Garden'];
  List<String> weatherOptions = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Windy',
    'Hot',
    'Cold',
    'Warm',
    'Windy',
    'Dry',
    'Tropical',
    'Humid',
    'Cool',
    'Moderate'
  ];

  // @override
  // bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Clear the plant list when this screen regains focus
    Provider.of<AppProvider>(context, listen: false).clearPlantLists();
  }

  @override
  void dispose() {
    // Clear all fields when navigating away
    _resetForm();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      selectedCategory = null;
      selectedWeather = null;
      currentWeather = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if "Fetch Plants" button should be enabled
    final isFetchPlantsEnabled = currentWeather != null &&
        selectedCategory != null &&
        selectedWeather != null;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: MyColors.whiteColor,
        ),
        title: const Text(
          'Plant Intelligence',
          style: TextStyle(
            color: MyColors.whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display live weather temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentWeather != null
                      ? 'Temperature: ${currentWeather!.temperature}°C'
                      : 'Temperature: --°C',
                  style: const TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: _fetchWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: isWeatherLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Weather Tracker',
                          style: TextStyle(
                            color: MyColors.whiteColor,
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomDropdown<String>(
              value: selectedCategory,
              hint: 'Select Category',
              items: categoryOptions,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomDropdown<String>(
              value: selectedWeather,
              hint: 'Select Weather Type',
              items: weatherOptions,
              onChanged: (value) {
                setState(() {
                  selectedWeather = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isFetchPlantsEnabled ? _fetchFilteredPlants : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: isFetchPlantsEnabled
                    ? Theme.of(context).primaryColor
                    : Colors.grey, // Disabled button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isPlantsLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Find Your Plants',
                      style: TextStyle(
                        color: MyColors.whiteColor,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isPlantsLoading
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Fetching plant list...',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  : Consumer<AppProvider>(
                      builder: (context, appProvider, child) {
                        if (appProvider.plantList.isEmpty) {
                          return Center(
                              child: Column(
                            children: [
                              Image.asset(
                                'assets/images/no_plants_available.jpg',
                                height: 250,
                                width: 250,
                              ),
                              const Text(
                                'No Plants Available',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ));
                        } else {
                          return ListView.builder(
                            itemCount: appProvider.plantList.length,
                            itemBuilder: (context, index) {
                              final plant = appProvider.plantList[index];
                              return PlantCard(plant: plant);
                            },
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchWeather() async {
    setState(() {
      isWeatherLoading = true;
    });

    try {
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);

      await locationProvider.fetchCurrentLocationAndCity();

      final weather = locationProvider.weather;

      if (weather != null) {
        setState(() {
          currentWeather = weather;
        });
      } else {
        throw Exception('Failed to fetch weather information.');
      }
    } catch (e) {
      errorMessage('Failed to fetch live Temperature');
      // errorMessage(e.toString());
    } finally {
      setState(() {
        isWeatherLoading = false;
      });
    }
  }

  Future<void> _fetchFilteredPlants() async {
    if (currentWeather == null) {
      errorMessage('Please fetch Weather first');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Please fetch weather first.')),
      // );
      return;
    }

    setState(() {
      isPlantsLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 3));

      await Provider.of<AppProvider>(context, listen: false).getFilteredPlants(
        enteredTemp: currentWeather!.temperature.toDouble(),
        selectedCategory: selectedCategory,
        selectedWeather: selectedWeather,
      );

      // Clear dropdown menus after fetching plants
      _resetForm();
    } catch (e) {
      errorMessage('Failed to fetch Plants Lists: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to fetch plants: $e')),
      // );
    } finally {
      setState(() {
        isPlantsLoading = false;
      });
    }
  }
}
