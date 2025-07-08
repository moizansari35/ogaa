// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ogaa/constants/constants.dart';
import 'package:ogaa/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ogaa/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:ogaa/models/plant_model/plant_model.dart';
import 'package:ogaa/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  // get user info from firebase function
  // UserModel? _userModel;
  // UserModel get getUserInfo => _userModel!;

  // UserModel? _userModel;
  // UserModel? get getUserInfo => _userModel;

  // void getUserInfoFirbase() async {
  //   _userModel = await FirebaseFirestoreHelper.instance.getUserInfo();
  //   notifyListeners();
  // }

  bool isLoading = true; // To track loading state
  UserModel? _userModel;

  UserModel get getUserInfo => _userModel!;

  // Fetch user info and manage loading state
  Future<void> getUserInfoFirebase() async {
    try {
      isLoading = true; // Start loading
      notifyListeners();

      _userModel = await FirebaseFirestoreHelper.instance.getUserInfo();

      isLoading = false; // Data fetched successfully
      notifyListeners();
    } catch (e) {
      isLoading = false; // Stop loading even if there's an error
      notifyListeners();
      rethrow; // Handle errors as needed
    }
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel usermodel, File? image) async {
    _userModel = usermodel;
    if (image == null) {
      showLoaderDialog(context);
      await FirebaseFirestore.instance
          .collection("users_ogaa_app")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      successMessage("Name Updated Successfully");

      Navigator.of(context, rootNavigator: true).pop();

      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(image);
      _userModel = usermodel.copyWith(
        image: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection("users_ogaa_app")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      notifyListeners();
      successMessage("Profile Updated Successfully");
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  //Plant Provider

  List<PlantModel> _plantList = [];

  List<PlantModel> get plantList => _plantList;

  void addPlantFirebase(
    String? imageUrl, // Allow the imageUrl to be nullable
    String name,
    String soilType,
    List<String> weatherType,
    List<String> categoryType,
    String description,
    double minTemp,
    double maxTemp,
  ) async {
    // Use a placeholder image URL if no URL is provided
    String finalImageUrl = imageUrl ??
        "https://png.pngtree.com/png-vector/20240207/ourmid/pngtree-indoor-plant-flowerpot-png-image_11669796.png";

    // Create a PlantModel using the provided data and image URL
    PlantModel newPlant = await FirebaseFirestoreHelper.instance.addSinglePlant(
      finalImageUrl, // Pass the URL directly
      name,
      soilType,
      weatherType,
      categoryType,
      description,
      minTemp,
      maxTemp,
    );

    // Add the new plant to the local list and notify listeners
    _plantList.add(newPlant);
    notifyListeners();
  }

  // Method to fetch and filter plants
  Future<void> getFilteredPlants({
    required double enteredTemp,
    String? selectedCategory,
    String? selectedWeather,
  }) async {
    try {
      // Clear the previous plant list before fetching new data
      _plantList = [];
      notifyListeners();

      // Fetch plants from Firebase
      List<PlantModel> allPlants =
          await FirebaseFirestoreHelper.instance.getPlantLists();

      // Filter plants based on conditions
      List<PlantModel> filteredPlants = allPlants.where((plant) {
        // Temperature range check
        bool temperatureMatch =
            enteredTemp >= plant.minTemp && enteredTemp <= plant.maxTemp;
        bool categoryMatch = selectedCategory == null ||
            plant.categoryType.contains(selectedCategory);
        bool weatherMatch = selectedWeather == null ||
            plant.weatherType.contains(selectedWeather);

        return temperatureMatch && categoryMatch && weatherMatch;
      }).toList();

      // Update the list with filtered plants
      _plantList = filteredPlants;

      // Notify listeners
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching filtered plants: $e");
    }
  }

  void clearPlantLists() {
    _plantList.clear();
    notifyListeners();
  }

  void clearUserData() {
    _userModel = null;
    // _plantList.clear();
    notifyListeners();
  }
}
