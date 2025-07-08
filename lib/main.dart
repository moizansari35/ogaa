import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ogaa/constants/theme.dart';
import 'package:ogaa/firebase_helper/firebase_options/firebase_options.dart';
import 'package:ogaa/provider/app_provider.dart';
import 'package:ogaa/screens/gemini_ai_chatbot/gemini_chat_provider.dart';
import 'package:ogaa/screens/location/location_provider.dart';
import 'package:ogaa/screens/splash_screen/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GeminiChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'OGAA',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                      start: 1921, end: double.infinity, name: '4K'),
                ],
              ),
          home: const SplashScreen()),
    );
  }
}
