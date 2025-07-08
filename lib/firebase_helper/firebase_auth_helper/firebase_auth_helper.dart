// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/constants.dart';
import 'package:ogaa/constants/routes/routes.dart';
import 'package:ogaa/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:ogaa/models/user_model/user_model.dart';
import 'package:ogaa/provider/app_provider.dart';
import 'package:ogaa/screens/auth_ui/login/login_screen.dart';
import 'package:ogaa/screens/homepage/welcome_screen.dart';
import 'package:provider/provider.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();

      // Check for specific error codes
      if (error.code == 'wrong-password') {
        errorMessage("The password is incorrect. Please try again.");
        debugPrint("The password is incorrect. Please try again.");
      } else if (error.code == 'user-not-found') {
        errorMessage("No user found with this email. Please sign up.");
        debugPrint("No user found with this email. Please sign up.");
      } else {
        errorMessage(error.message ?? "An unexpected error occurred.");
        debugPrint(error.message ?? "An unexpected error occurred.");
      }
    }
    return false;
  }

  // Future<bool> login(
  //     String email, String password, BuildContext context) async {
  //   try {
  //     showLoaderDialog(context);
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);

  //     Navigator.of(
  //       context,
  //       rootNavigator: true,
  //     ).pop();
  //     return true;
  //   } on FirebaseAuthException catch (error) {
  //     Navigator.of(
  //       context,
  //       rootNavigator: true,
  //     ).pop();
  //     errorMessage(error.code.toString());
  //   }
  //   {
  //     return false;
  //   }
  // }

  Future<bool> signUp(
    String name,
    String email,
    String password,
    BuildContext context,
    File? image, // Accept the image as a parameter
  ) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? imageUrl;
      if (image != null) {
        // Upload the image if selected
        imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(image);
      }

      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        image: imageUrl, // Store image URL or null
      );
      _firestore
          .collection("users_ogaa_app")
          .doc(userModel.id)
          .set(userModel.toJson());
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      errorMessage(error.code.toString());
    }
    return false;
  }

  void logout(BuildContext context) async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

    // Reset user data in provider
    appProvider.clearUserData();

    // Navigate to WelcomeScreen and remove previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }

  // void logOut(BuildContext context) async {

  //   try {
  //     await _auth.signOut();
  //     successMessage("Logout");
  //     // Routes.routesInstance.pushandRemoveUntil(const WelcomeScreen(), context);
  //     debugPrint("User Logged Out!"); // Debugging Statement

  //     // Navigate to WelcomeScreen and remove all previous screens
  //     Future.delayed(const Duration(milliseconds: 1000), () {
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
  //         (route) => false,
  //       );
  //     });
  //   } catch (e) {
  //     errorMessage(e.toString());
  //   }
  // }

  // void logOut(BuildContext context) async {
  //   try {
  //     await _auth.signOut(); // Sign out the user
  //     successMessage("Logged out successfully");
  //     // Navigate to WelcomeScreen and clear the stack
  //     Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (_) => const WelcomeScreen()),
  //       (route) => false, // Removes all previous routes
  //     );
  //   } catch (e) {
  //     errorMessage(e.toString());
  //   }
  // }

  // void logOut(BuildContext context) async {
  //   // Show the loading dialog
  //   showLoaderDialog(context);

  //   try {
  //     // Simulate a delay for logout process
  //     await Future.delayed(const Duration(seconds: 3));

  //     // Perform logout
  //     await _auth.signOut();

  //     // Dismiss the dialog
  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop();
  //     }

  //     // Show success message
  //     successMessage("Logout");

  //     // Navigate to WelcomeScreen
  //     Routes.routesInstance.pushandRemoveUntil(const WelcomeScreen(), context);
  //   } catch (e) {
  //     // Dismiss the dialog in case of an error
  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop();
  //     }

  //     // Show error message
  //     errorMessage(e.toString());
  //   }
  // }

  Future<bool> changePasssowrd(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      FirebaseAuth.instance.currentUser!.updatePassword(password);

      Navigator.of(context, rootNavigator: true).pop();
      Routes.routesInstance.pushandRemoveUntil(const LoginScreen(), context);
      successMessage(
          'Password Changed Successfully\nNeed to Sign in again with New Password');

      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      errorMessage(error.code.toString());
    }
    {
      return false;
    }
  }
}
