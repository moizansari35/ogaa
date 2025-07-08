// import 'package:flutter/material.dart';
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/screens/account_screen/account_screen.dart';
import 'package:ogaa/screens/gemini_ai_chatbot/gemini_Ai_chatbot.dart';
import 'package:ogaa/screens/homepage/homepage.dart';
import 'package:ogaa/screens/plants_screens/plants_grid_page.dart';
import 'package:ogaa/screens/plants_screens/plants_list.dart';

class FlutterCustomBottomNavBar extends StatefulWidget {
  const FlutterCustomBottomNavBar({super.key});

  @override
  State<FlutterCustomBottomNavBar> createState() =>
      _FlutterCustomBottomNavBarState();
}

class _FlutterCustomBottomNavBarState extends State<FlutterCustomBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Homepage(),
    const PlantsGridPage(
      allPlants: PlantLists.allPlants,
    ),
    const GeminiAiChatbot(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onWillPop() async {
    // Show the confirmation dialog
    final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Do you Want to Close the App?"),
            actions: [
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // Close the app
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // Close the dialog
                },
                child: const Text("No"),
              ),
            ],
          ),
        ) ??
        false; // If no result, return false (do nothing)
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: MyColors.whiteColor,
          unselectedItemColor: MyColors.whiteColor.withOpacity(0.6),
          backgroundColor: MyColors.primaryColor,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              label: "All Plants",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy),
              label: "Ogaa AI",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "My Account",
            ),
          ],
        ),
        // onWillPop: _onWillPop, // Correctly set up onWillPop
      ),
    );
  }
}
