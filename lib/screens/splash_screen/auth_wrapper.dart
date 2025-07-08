import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/custom_bottom_nav_bar/flutter_custom_bottom_nav_bar.dart';
import 'package:ogaa/screens/homepage/welcome_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the auth state, show a loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          // If the user is logged in, navigate to the Home screen
          return const FlutterCustomBottomNavBar();
        } else {
          // If the user is not logged in, navigate to the Welcome screen
          return const WelcomeScreen();
        }
      },
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ogaa/screens/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
// import 'package:ogaa/screens/homepage/welcome_screen.dart';

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }

//         if (snapshot.hasData) {
//           // If Firebase has a user but Provider data is not loaded, show a loader
//           return const CustomBottomNavBar();
//         } else {
//           return const WelcomeScreen();
//         }
//       },
//     );
//   }
// }


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ogaa/screens/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
// import 'package:ogaa/screens/homepage/welcome_screen.dart';

// class AuthWrapper extends StatefulWidget {
//   const AuthWrapper({super.key});

//   @override
//   _AuthWrapperState createState() => _AuthWrapperState();
// }

// class _AuthWrapperState extends State<AuthWrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else {
//           // Delay navigation until the next frame
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (snapshot.hasData) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const CustomBottomNavBar()),
//               );
//             } else {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//               );
//             }
//           });

//           return const Scaffold(
//             body: Center(
//                 child: CircularProgressIndicator()), // Temporary loading screen
//           );
//         }
//       },
//     );
//   }
// }



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ogaa/screens/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
// import 'package:ogaa/screens/homepage/welcome_screen.dart';

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Show loading while waiting for auth state
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasData) {
//           // User is logged in, navigate to Home screen
//           Future.delayed(Duration.zero, () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const CustomBottomNavBar()),
//             );
//           });
//           return const SizedBox(); // Return an empty widget while navigating
//         } else {
//           // User is not logged in, navigate to Welcome screen
//           Future.delayed(Duration.zero, () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//             );
//           });
//           return const SizedBox(); // Return an empty widget while navigating
//         }
//       },
//     );
//   }
// }