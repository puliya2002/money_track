import 'dart:io';

import 'package:money_track/pages/register_page.dart';
import 'package:money_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/login_page.dart';
import 'auth/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDq4qyRToh1Rp9bZ5CFzm6-nU7EpMwlRmI",
      appId: "1:884136659220:android:841fb1cd2bfe2a74169a01",
      messagingSenderId: "884136659220",
      projectId: "fir-tutorial-fa351",
    ),
  )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      // theme: ThemeData(
      //   colorScheme: const ColorScheme.light(
      //     background: Color(0xFFf3f6f9),
      //     onBackground: Color(0xFF363637),
      //     primary: Color(0xFF2291fd),
      //     secondary: Color(0xFF6dd2ff),
      //   ),
      // ),
      home: const MainPage(),
    );
  }
}
