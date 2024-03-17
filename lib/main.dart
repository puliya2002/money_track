import 'dart:io';

import 'package:money_track/pages/register_page.dart';
import 'package:money_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:money_track/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/login_page.dart';
import 'auth/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBC4X0o96xhTn2ppS3l7AYHoFqRFjfS4nQ",
      appId: "1:34873365969:android:894a255f833f51c8d2bcf0",
      messagingSenderId: "34873365969",
      projectId: "money-track-3cf70",
    ),
  )
      : await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).getTheme(),
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
