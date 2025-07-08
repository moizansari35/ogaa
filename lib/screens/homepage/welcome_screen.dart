import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/assets_path.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/screens/auth_ui/login/login_screen.dart';
import 'package:ogaa/screens/auth_ui/login/signup/signup_screen.dart';
import 'package:ogaa/widgets/buttons/primary_button.dart';
import 'package:ogaa/widgets/titles/top_titles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                title: "Welcome",
                subtitle: "In the World of Plants and Greenery",
              ),
              Center(
                child: Image.asset(
                  AssetsImages.assetsImages.welcome2Image,
                  scale: 2,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      AssetsIcons.assetsIcons.fbIcon,
                      scale: 65,
                    ),
                  ),
                  const SizedBox(width: 15), // Fixed spacing
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      AssetsIcons.assetsIcons.googleIcon,
                      scale: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyPrimaryButton(
                title: "Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
              MyPrimaryButton(
                title: "Signup",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
              ),
              Expanded(child: Container()), // Replaces Spacer()
              const Center(
                child: Text(
                  "Design & Developed by Moiz Ahmed Ansari!",
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: MyColors.blackColor,
                        offset: Offset(0.5, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
