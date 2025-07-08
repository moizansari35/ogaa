// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/routes/routes.dart';
import 'package:ogaa/constants/sized_box.dart';
import 'package:ogaa/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ogaa/provider/app_provider.dart';
import 'package:ogaa/screens/about_screen/about_screen.dart';
import 'package:ogaa/screens/change_password/change_password.dart';
import 'package:ogaa/screens/edit_profile/edit_profile.dart';
import 'package:ogaa/widgets/buttons/primary_button.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyColors.primaryColor, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: appProvider
                                          .getUserInfo.image?.isNotEmpty ==
                                      true &&
                                  Uri.parse(appProvider.getUserInfo.image!)
                                      .isAbsolute
                              ? NetworkImage(appProvider
                                  .getUserInfo.image!) // Network image URL
                              : const AssetImage(
                                  'assets/images/default_profile_image.png'), // Local asset
                        ),
                        const SizedBox(height: 10),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            appProvider.getUserInfo.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          appProvider.getUserInfo.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: MyColors.blackColor,
                          ),
                        ),
                        15.height,
                        SizedBox(
                          width: context.screenWidth / 2,
                          child: MyPrimaryButton(
                            onPressed: () {
                              Routes.routesInstance.push(
                                widget: const EditProfile(),
                                context: context,
                              );
                            },
                            title: "Edit Profile",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    _buildListTile(
                      title: "About us",
                      icon: Icons.info_outline,
                      onTap: () {
                        Routes.routesInstance.push(
                            widget: const AboutScreen(), context: context);
                      },
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    _buildListTile(
                      title: "Change Password",
                      icon: Icons.change_circle_outlined,
                      onTap: () {
                        Routes.routesInstance.push(
                            widget: const ChangePassword(), context: context);
                      },
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    _buildListTile(
                      title: "Log out",
                      icon: Icons.logout_outlined,
                      onTap: () {
                        FirebaseAuthHelper.instance.logout(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: MyColors.primaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
