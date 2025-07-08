import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class CustomLatLng {
  final double latitude;
  final double longitude;

  CustomLatLng(this.latitude, this.longitude);
}

class LocationService {
  static Future<Placemark?> latLngToPlacemark(CustomLatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      return placemarks.isNotEmpty ? placemarks.first : null;
    } catch (e) {
      debugPrint("Error converting LatLng to Placemark: $e");
      return null;
    }
  }

  static Future<CustomLatLng?> addressToLatLng(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return CustomLatLng(
            locations.first.latitude, locations.first.longitude);
      }
      return null;
    } catch (e) {
      debugPrint("Error converting address to LatLng: $e");
      return null;
    }
  }

  static Future<CustomLatLng?> getCurrentLocation() async {
    try {
      loc.Location location = loc.Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return null;
      }

      loc.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) return null;
      }

      loc.LocationData locationData = await location.getLocation();
      return CustomLatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      debugPrint("Error getting current location: $e");
      return null;
    }
  }
}
