import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/screens/account_screen/account_screen.dart';
import 'package:ogaa/screens/gemini_ai_chatbot/gemini_Ai_chatbot.dart';
import 'package:ogaa/screens/homepage/homepage.dart';
import 'package:ogaa/screens/plants_screens/plants_grid_page.dart';
import 'package:ogaa/screens/plants_screens/plants_list.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final PersistentTabController tabController = PersistentTabController();
  final bool _hideNavbar = false;
  @override
  void dispose() {
    tabController
        .dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  List<Widget> _buildScreens() => [
        const Homepage(),
        const PlantsGridPage(
          allPlants: PlantLists.allPlants,
        ),
        const GeminiAiChatbot(),
        const AccountScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(
            Icons.home_outlined,
          ),
          title: "Home",
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          activeColorPrimary: MyColors.whiteColor,
          inactiveColorPrimary: MyColors.whiteColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.wb_sunny,
          ),
          inactiveIcon: const Icon(
            Icons.wb_sunny_outlined,
          ),
          title: "All Plants",
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          activeColorPrimary: MyColors.whiteColor,
          inactiveColorPrimary: MyColors.whiteColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.smart_toy,
          ),
          inactiveIcon: const Icon(
            Icons.smart_toy_outlined,
          ),
          title: "Ogaa AI",
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          activeColorPrimary: MyColors.whiteColor,
          inactiveColorPrimary: MyColors.whiteColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(
            Icons.person_outline,
          ),
          title: "My Account",
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          activeColorPrimary: MyColors.whiteColor,
          inactiveColorPrimary: MyColors.whiteColor,
        ),
      ];
  @override
  Widget build(final BuildContext context) => Scaffold(
          body: PersistentTabView(
        context,
        controller: tabController,
        screens: _buildScreens(),
        items: _navBarItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: kBottomNavigationBarHeight,
        bottomScreenMargin: 50,
        onWillPop: (final context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (final context) => Center(
              child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do you Want to Close the App",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              SystemNavigator.pop(); //Close the App
                            },
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    MyColors.primaryColor)),
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); //Close the Dialog
                            },
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    MyColors.primaryColor)),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          );
          return false;
        },
        backgroundColor: MyColors.primaryColor,
        handleAndroidBackButtonPress: true,
        hideNavigationBarWhenKeyboardAppears: _hideNavbar,
        decoration: const NavBarDecoration(
          colorBehindNavBar: MyColors.primaryColor,
        ),
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
          ),
        ),
        navBarStyle: NavBarStyle.style1,
      ));
}
