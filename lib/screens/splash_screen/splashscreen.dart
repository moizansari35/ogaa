// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/screens/splash_screen/auth_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      // Attempt to listen to the Firebase Auth stream to check if Firebase is initialized properly
      await FirebaseAuth.instance.authStateChanges().first;

      // If no error, navigate to AuthWrapper
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
      );
    } catch (e) {
      debugPrint("🔥 Firebase Auth error during splash: $e");

      // Optional: Show fallback UI if Firebase fails
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Scaffold(
            backgroundColor: MyColors.primaryColor,
            body: Center(
              child: Text(
                'Error loading app. Please restart.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash_image2.png',
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'OGAA',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: MyColors.blackColor.withOpacity(0.5),
                    offset: const Offset(5.0, 5.0),
                  ),
                ],
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [MyColors.primaryColor, MyColors.secondaryColor],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:ogaa/constants/colors.dart';
// import 'package:ogaa/screens/splash_screen/auth_wrapper.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     // Delay for 3 seconds, then navigate
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const AuthWrapper()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: MyColors.primaryColor,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/splash_image2.png',
//                 width: 300,
//                 height: 300,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Enhanced text styling with gradient, shadow, and spacing
//             Text(
//               'OGAA',
//               style: TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 3,
//                 shadows: [
//                   Shadow(
//                     blurRadius: 10.0,
//                     color: MyColors.blackColor.withOpacity(0.5),
//                     offset: const Offset(5.0, 5.0),
//                   ),
//                 ],
//                 foreground: Paint()
//                   ..shader = const LinearGradient(
//                     colors: [MyColors.primaryColor, MyColors.secondaryColor],
//                   ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

