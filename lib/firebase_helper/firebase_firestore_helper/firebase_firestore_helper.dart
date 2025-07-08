import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/models/plant_model/plant_model.dart';
import 'package:ogaa/models/user_model/user_model.dart';
import 'package:ogaa/screens/add_plants_screen/plant_static_list.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<UserModel> getUserInfo() async {
    //String docsid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firebaseFirestore
            .collection("users_ogaa_app")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(documentSnapshot.data()!);
  }

  // Plant Logics

  /////////////////////
  Future<PlantModel> addSinglePlant(
    String imageUrl, // Directly pass the image URL
    String name,
    String soilType,
    List<String> weatherType,
    List<String> categoryType,
    String description,
    double minTemp,
    double maxTemp,
  ) async {
    // Create a new document reference
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("plants_ogaa_app").doc();

    // Create the PlantModel object
    PlantModel newPlant = PlantModel(
      id: documentReference.id,
      name: name,
      imageUrl: imageUrl, // Use the provided URL
      soilType: soilType,
      weatherType: weatherType,
      categoryType: categoryType,
      description: description,
      minTemp: minTemp,
      maxTemp: maxTemp,
    );

    // Save the new plant directly to Firestore
    await documentReference.set(newPlant.toJson());

    return newPlant;
  }

  Future<List<PlantModel>> getPlantLists() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('plants_ogaa_app').get();

      return snapshot.docs.map((doc) {
        return PlantModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint("Error fetching plant data: $e");
      return [];
    }
  }

  Future<void> addMultiplePlantsToFirebase() async {
    CollectionReference plantsCollection =
        FirebaseFirestore.instance.collection('plants_ogaa_app');

    for (Map<String, dynamic> plantData in plantList) {
      try {
        // Generate a new document reference
        DocumentReference docRef = plantsCollection.doc();

        // Create a PlantModel object to ensure data consistency
        PlantModel newPlant = PlantModel(
          id: docRef.id,
          name: plantData['name'],
          imageUrl: plantData['imageUrl'],
          soilType: plantData['soilType'],
          weatherType: List<String>.from(plantData['weatherType']),
          categoryType: List<String>.from(plantData['categoryType']),
          description: plantData['description'],
          minTemp: plantData['minTemp'],
          maxTemp: plantData['maxTemp'],
        );

        // Save the plant data to Firestore
        await docRef.set(newPlant.toJson());

        debugPrint('Plant added with ID: ${docRef.id}');
      } catch (e) {
        debugPrint('Error adding plant: $e');
      }
    }
  }
}
