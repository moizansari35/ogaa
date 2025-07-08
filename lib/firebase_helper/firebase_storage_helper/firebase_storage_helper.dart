import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadUserImage(File image) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot = await _storage
        .ref('user_profile_images_ogaa_app/$userId')
        .putFile(image);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  // Future<String> uploadPlantImage(String plantId, File image) async {
  //   TaskSnapshot taskSnapshot =
  //       await _storage.ref('plant_images_ogaa_app/$plantId').putFile(image);
  //   String imageUrl = await taskSnapshot.ref.getDownloadURL();

  //   return imageUrl;
  // }

  // // Upload the image to Firebase Storage and get the download URL
  // Future<String> uploadImageToFirebase(File? imageFile) async {
  //   if (imageFile == null) {
  //     throw Exception("No image selected.");
  //   }
  //   try {
  //     // Create a unique name for the image
  //     String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

  //     // Upload the image to Firebase Storage
  //     Reference ref = FirebaseStorage.instance.ref().child('plants/$fileName');
  //     UploadTask uploadTask = ref.putFile(imageFile);

  //     // Wait for the upload to complete and get the download URL
  //     TaskSnapshot snapshot = await uploadTask;
  //     String downloadUrl = await snapshot.ref.getDownloadURL();

  //     return downloadUrl;
  //   } catch (e) {
  //     debugPrint('Error uploading image: $e');
  //     rethrow; // Rethrow the error if needed
  //   }
  // }
}
