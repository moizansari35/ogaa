import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ogaa/screens/location/location_services.dart';
import 'package:ogaa/screens/weather/weather_model.dart';
import 'package:ogaa/screens/weather/weather_service.dart';

class LocationProvider with ChangeNotifier {
  String _city = "Fetching location...";
  CustomLatLng? _currentLatLng;
  WeatherModel? _weather; // Add a property to store weather data.

  // Getters to expose data to the UI.
  String get city => _city;
  CustomLatLng? get currentLatLng => _currentLatLng;
  WeatherModel? get weather => _weather; // Getter for weather data.

  final WeatherService _weatherService =
      WeatherService(); // WeatherService instance.

  // Constructor to fetch the city and current location when the provider is created.
  LocationProvider() {
    fetchCurrentLocationAndCity();
  }

  // Fetch the current location and city.
  Future<void> fetchCurrentLocationAndCity() async {
    _currentLatLng = await LocationService.getCurrentLocation();

    if (_currentLatLng != null) {
      // Fetch the city name from the current location.
      Placemark? placemark =
          await LocationService.latLngToPlacemark(_currentLatLng!);
      _city = placemark != null
          ? "${placemark.locality}, ${placemark.country}"
          : "Location not found";

      // Fetch the weather for the current city after getting the location.
      await fetchWeather(_city);
    } else {
      _city = "Unable to fetch location.";
    }

    // Notify listeners after updating the values.
    notifyListeners();
  }

  // Fetch weather for the city.
  Future<void> fetchWeather(String city) async {
    try {
      _weather = await _weatherService.getWeather(city);
    } catch (error) {
      _weather = null; // Handle errors if necessary.
    }
    notifyListeners();
  }

  // Fetch LatLng from an address and update the city.
  Future<void> fetchLatLngFromAddress(String address) async {
    _currentLatLng = await LocationService.addressToLatLng(address);
    if (_currentLatLng != null) {
      Placemark? placemark =
          await LocationService.latLngToPlacemark(_currentLatLng!);
      _city = placemark != null
          ? "${placemark.locality}, ${placemark.country}"
          : "Location not found";

      // Fetch weather for the new city.
      await fetchWeather(_city);
    } else {
      _city = "Address not found.";
    }

    notifyListeners();
  }
}
