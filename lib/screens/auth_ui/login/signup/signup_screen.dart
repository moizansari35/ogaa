// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ogaa/constants/colors.dart';
// import 'package:ogaa/constants/constants.dart';
// import 'package:ogaa/widgets/buttons/primary_button.dart';

// import '../../../../constants/routes/routes.dart';
// import '../../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
// import '../../../custom_bottom_nav_bar/custom_bottom_nav_bar.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool isShowPassword = true;
//   File? selectedImage; // Variable to hold selected image

//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImage() async {
//     // Pick an image from the gallery
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         selectedImage = File(pickedFile.path);
//       });
//     }
//   }

// ignore_for_file: deprecated_member_use

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/signup_illustration.png',
//                 height: 220,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Create Your Account",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Text(
//                 "Join us and explore",
//                 style: TextStyle(color: MyColors.greyColor, fontSize: 16),
//               ),
//               const SizedBox(height: 30),
//               // Image Picker
//               GestureDetector(
//                 onTap: pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundColor: MyColors.primaryColor.withOpacity(0.8),
//                   backgroundImage: selectedImage != null
//                       ? FileImage(selectedImage!) // Display selected image
//                       : null,
//                   child: selectedImage == null
//                       ? const Icon(
//                           Icons.add_a_photo,
//                           color: MyColors.whiteColor,
//                         ) // Default icon
//                       : null,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your name",
//                   prefixIcon: const Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your email",
//                   prefixIcon: const Icon(Icons.email),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: phoneController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your phone",
//                   prefixIcon: const Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: passwordController,
//                 obscureText: isShowPassword,
//                 decoration: InputDecoration(
//                   hintText: "Enter your password",
//                   prefixIcon: const Icon(Icons.lock),
//                   suffixIcon: IconButton(
//                     icon: Icon(isShowPassword
//                         ? Icons.visibility_off
//                         : Icons.visibility),
//                     onPressed: () {
//                       setState(() {
//                         isShowPassword = !isShowPassword;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               MyPrimaryButton(
//                 onPressed: () async {
//                   bool isValidated = signUpValidation(
//                     nameController.text,
//                     emailController.text,
//                     phoneController.text,
//                     passwordController.text,
//                   );
//                   if (isValidated) {
//                     bool isLogin = await FirebaseAuthHelper.instance.signUp(
//                       nameController.text,
//                       emailController.text,
//                       passwordController.text,
//                       context,
//                       selectedImage, // Pass selected image to the function
//                     );
//                     if (isLogin) {
//                       Routes.routesInstance.pushandRemoveUntil(
//                           const CustomBottomNavBar(), context);
//                     }
//                   }
//                 },
//                 title: "Sign Up",
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account? "),
//                   CupertinoButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(color: MyColors.primaryColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/constants.dart';
import 'package:ogaa/constants/routes/routes.dart';
import 'package:ogaa/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:ogaa/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ogaa/widgets/buttons/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  bool isShowPassword = true;
  bool isFormValid = false;

  String nameError = '';
  String emailError = '';
  String phoneError = '';
  String passwordError = '';

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();

    // Focus listeners for validation
    nameFocusNode.addListener(() {
      if (!nameFocusNode.hasFocus) _validateName();
    });
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) _validateEmail();
    });
    phoneFocusNode.addListener(() {
      if (!phoneFocusNode.hasFocus) _validatePhone();
    });
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) _validatePassword();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void _validateName() {
    setState(() {
      nameError = nameController.text.isEmpty ? "Name cannot be empty" : '';
    });
  }

  void _validateEmail() {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    setState(() {
      emailError = emailRegExp.hasMatch(emailController.text)
          ? ''
          : "Please enter a valid email (@gmail.com required)";
    });
  }

  void _validatePhone() {
    setState(() {
      phoneError = phoneController.text.length == 11
          ? ''
          : "Phone number must be 11 digits";
    });
  }

  void _validatePassword() {
    setState(() {
      passwordError = passwordController.text.length >= 8
          ? ''
          : "Password must be at least 8 characters";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/signup_illustration.png',
                  height: 220,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Join us and explore",
                  style: TextStyle(color: MyColors.greyColor, fontSize: 16),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: MyColors.primaryColor.withOpacity(0.8),
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : null,
                    child: selectedImage == null
                        ? const Icon(
                            Icons.add_a_photo,
                            color: MyColors.whiteColor,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    prefixIcon: const Icon(Icons.person),
                    errorText: nameError.isNotEmpty ? nameError : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email),
                    errorText: emailError.isNotEmpty ? emailError : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter your phone",
                    prefixIcon: const Icon(Icons.phone),
                    errorText: phoneError.isNotEmpty ? phoneError : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(isShowPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                    ),
                    errorText: passwordError.isNotEmpty ? passwordError : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MyPrimaryButton(
                  onPressed: () async {
                    _validateName();
                    _validateEmail();
                    _validatePhone();
                    _validatePassword();

                    if (nameError.isEmpty &&
                        emailError.isEmpty &&
                        phoneError.isEmpty &&
                        passwordError.isEmpty) {
                      bool isValidated = signUpValidation(
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                        passwordController.text,
                      );

                      if (isValidated) {
                        bool isSignUp =
                            await FirebaseAuthHelper.instance.signUp(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          context,
                          selectedImage,
                        );

                        if (isSignUp) {
                          Routes.routesInstance.pushandRemoveUntil(
                            const CustomBottomNavBar(),
                            context,
                          );
                        }
                      }
                    }
                  },
                  title: "Sign Up",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    CupertinoButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: MyColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
