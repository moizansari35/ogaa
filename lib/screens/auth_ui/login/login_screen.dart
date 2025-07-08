// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:ogaa/constants/colors.dart';
// // import 'package:ogaa/constants/routes/routes.dart';
// // import 'package:ogaa/screens/auth_ui/login/signup/signup_screen.dart';
// // import 'package:ogaa/widgets/buttons/primary_button.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _animationController;
// //   late Animation<double> _fadeAnimation;
// //   TextEditingController emailController = TextEditingController();
// //   TextEditingController passwordController = TextEditingController();
// //   bool isShowPassword = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _animationController =
// //         AnimationController(vsync: this, duration: const Duration(seconds: 1));
// //     _fadeAnimation = CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeIn,
// //     );
// //     _animationController.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: FadeTransition(
// //         opacity: _fadeAnimation,
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 Image.asset(
// //                   'assets/images/login_illustration.png',
// //                   height: 200,
// //                 ),
// //                 const SizedBox(height: 30),
// //                 const Text(
// //                   "Welcome Back",
// //                   style: TextStyle(
// //                     fontSize: 32,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 const Text(
// //                   "Login to continue",
// //                   style: TextStyle(color: MyColors.greyColor, fontSize: 16),
// //                 ),
// //                 const SizedBox(height: 40),
// //                 TextFormField(
// //                   controller: emailController,
// //                   decoration: InputDecoration(
// //                     hintText: "Enter your email",
// //                     prefixIcon: const Icon(Icons.email),
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 TextFormField(
// //                   controller: passwordController,
// //                   obscureText: isShowPassword,
// //                   decoration: InputDecoration(
// //                     hintText: "Enter your password",
// //                     prefixIcon: const Icon(Icons.lock),
// //                     suffixIcon: IconButton(
// //                       icon: Icon(isShowPassword
// //                           ? Icons.visibility_off
// //                           : Icons.visibility),
// //                       onPressed: () {
// //                         setState(() {
// //                           isShowPassword = !isShowPassword;
// //                         });
// //                       },
// //                     ),
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 30),
// //                 MyPrimaryButton(
// //                   onPressed: () async {
// //                     // Keep the same login logic
// //                   },
// //                   title: "Login",
// //                 ),
// //                 const SizedBox(height: 20),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const Text("Don't have an account? "),
// //                     CupertinoButton(
// //                       onPressed: () {
// //                         Routes.routesInstance.push(
// //                           widget: const SignupScreen(),
// //                           context: context,
// //                         );
// //                       },
// //                       child: const Text(
// //                         "Sign up",
// //                         style: TextStyle(color: MyColors.primaryColor),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ogaa/constants/colors.dart';
// import 'package:ogaa/constants/constants.dart';
// import 'package:ogaa/constants/routes/routes.dart';
// import 'package:ogaa/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
// import 'package:ogaa/screens/auth_ui/login/signup/signup_screen.dart';
// import 'package:ogaa/widgets/buttons/primary_button.dart';

// import '../../custom_bottom_nav_bar/custom_bottom_nav_bar.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   bool isShowPassword = true;
//   bool isEmailValid = false;
//   bool isPasswordValid = false;
//   bool isFormValid = false;
//   String emailError = '';
//   String passwordError = '';

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeIn,
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   // Validate Email
//   bool _validateEmail(String email) {
//     final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
//     return emailRegExp.hasMatch(email);
//   }

//   // Validate Password
//   bool _validatePassword(String password) {
//     return password.length >= 8; // Minimum 8 characters
//   }

//   // Check form validity
//   void _checkFormValidity() {
//     setState(() {
//       isEmailValid = _validateEmail(emailController.text);
//       isPasswordValid = _validatePassword(passwordController.text);
//       emailError =
//           isEmailValid ? '' : 'Please enter a valid email (must be @gmail.com)';
//       passwordError =
//           isPasswordValid ? '' : 'Password must be at least 8 characters';
//       isFormValid = isEmailValid && isPasswordValid;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/login_illustration.png',
//                   height: 200,
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   "Welcome Back",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text(
//                   "Login to continue",
//                   style: TextStyle(color: MyColors.greyColor, fontSize: 16),
//                 ),
//                 const SizedBox(height: 40),
//                 // Email Field
//                 TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     hintText: "Enter your email",
//                     prefixIcon: const Icon(Icons.email),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     errorText: emailError.isNotEmpty ? emailError : null,
//                   ),
//                   onChanged: (value) => _checkFormValidity(),
//                 ),
//                 const SizedBox(height: 20),

//                 // Password Field
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: isShowPassword,
//                   decoration: InputDecoration(
//                     hintText: "Enter your password",
//                     prefixIcon: const Icon(Icons.lock),
//                     suffixIcon: IconButton(
//                       icon: Icon(isShowPassword
//                           ? Icons.visibility_off
//                           : Icons.visibility),
//                       onPressed: () {
//                         setState(() {
//                           isShowPassword = !isShowPassword;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     errorText: passwordError.isNotEmpty ? passwordError : null,
//                   ),
//                   onChanged: (value) => _checkFormValidity(),
//                 ),
//                 const SizedBox(height: 30),

//                 // Login Button
//                 MyPrimaryButton(
//                   onPressed: isFormValid
//                       ? () async {
//                           bool isValidated = loginValidation(
//                               emailController.text, passwordController.text);
//                           if (isValidated) {
//                             bool isLogin =
//                                 await FirebaseAuthHelper.instance.login(
//                               emailController.text,
//                               passwordController.text,
//                               context,
//                             );
//                             if (isLogin) {
//                               Routes.routesInstance.pushandRemoveUntil(
//                                   const CustomBottomNavBar(), context);
//                             }
//                           }
//                         }
//                       : () {
//                           // Do nothing when the form is invalid
//                         },
//                   title: "Login",
//                 ),

//                 const SizedBox(height: 20),

//                 // Sign Up Navigation
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Don't have an account? "),
//                     CupertinoButton(
//                       onPressed: () {
//                         Routes.routesInstance.push(
//                           widget: const SignupScreen(),
//                           context: context,
//                         );
//                       },
//                       child: const Text(
//                         "Sign up",
//                         style: TextStyle(color: MyColors.primaryColor),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/constants/constants.dart';
import 'package:ogaa/constants/routes/routes.dart';
import 'package:ogaa/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ogaa/screens/auth_ui/login/signup/signup_screen.dart';
import 'package:ogaa/widgets/buttons/primary_button.dart';

import '../../../custom_bottom_nav_bar/custom_bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isShowPassword = true;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isFormValid = false;
  String emailError = '';
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

    // Add focus change listeners
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        _validateEmailOnFocusLost();
      }
    });

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        _validatePasswordOnFocusLost();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  // Validate Email
  bool _validateEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return emailRegExp.hasMatch(email);
  }

  // Validate Password
  bool _validatePassword(String password) {
    return password.length >= 8; // Minimum 8 characters
  }

  // Validate Email on Focus Loss
  void _validateEmailOnFocusLost() {
    setState(() {
      isEmailValid = _validateEmail(emailController.text);
      emailError =
          isEmailValid ? '' : 'Please enter a valid email (must be @gmail.com)';
    });
  }

  // Validate Password on Focus Loss
  void _validatePasswordOnFocusLost() {
    setState(() {
      isPasswordValid = _validatePassword(passwordController.text);
      passwordError =
          isPasswordValid ? '' : 'Password must be at least 8 characters';
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
                  'assets/images/login_illustration.png',
                  height: 200,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Login to continue",
                  style: TextStyle(color: MyColors.greyColor, fontSize: 16),
                ),
                const SizedBox(height: 40),
                // Email Field
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: emailError.isNotEmpty ? emailError : null,
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: passwordError.isNotEmpty ? passwordError : null,
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button
                MyPrimaryButton(
                  onPressed: () async {
                    _validateEmailOnFocusLost();
                    _validatePasswordOnFocusLost();

                    if (isEmailValid && isPasswordValid) {
                      bool isValidated = loginValidation(
                        emailController.text,
                        passwordController.text,
                      );

                      if (isValidated) {
                        bool isLogin = await FirebaseAuthHelper.instance.login(
                          emailController.text,
                          passwordController.text,
                          context,
                        );

                        if (isLogin) {
                          Routes.routesInstance.pushandRemoveUntil(
                            const CustomBottomNavBar(),
                            context,
                          );
                        }
                      }
                    }
                  },
                  title: "Login",
                ),

                const SizedBox(height: 20),

                // Sign Up Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    CupertinoButton(
                      onPressed: () {
                        Routes.routesInstance.push(
                          widget: const SignupScreen(),
                          context: context,
                        );
                      },
                      child: const Text(
                        "Sign up",
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
