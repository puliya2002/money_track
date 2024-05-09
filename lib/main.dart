import 'dart:io';

import 'package:money_track/provider/business_personal_provider.dart';
import 'package:money_track/screens/foget_password_screen.dart';
import 'package:money_track/screens/home_screen.dart';
import 'package:money_track/screens/main_screen.dart';
import 'package:money_track/screens/pie_chart_screen.dart';
import 'package:money_track/screens/profile_screen.dart';
import 'package:money_track/screens/register_screen.dart';
import 'package:money_track/screens/states_screen.dart';
import 'package:money_track/screens_business/home_screen_business.dart';
import 'package:money_track/screens_business/main_screen_business.dart';
import 'package:money_track/screens_business/pie_chart_screen_business.dart';

import 'package:money_track/screens_business/states_screen_business.dart';
import 'package:money_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:money_track/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'auth/main_page.dart';
import 'provider/currency_provider.dart';

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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CurrencyProvider()),
        ChangeNotifierProvider(create: (context) => SwitchProvider()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).getTheme(),


      // initialRoute: '/homeScreenBusiness',
      routes: {
        '/register': (context) => RegisterScreen(showLoginPage: () {  },),
        '/login': (context) => LoginScreen(showRegisterPage: () {  },),
        '/forgetPassword': (context) => ForgetPasswordScreen(),
        '/home': (context) => HomeScreen(),
        '/mainScreen': (context) => MainScreen(),
        '/stateScreen': (context) => StatScreen(),
        '/profileScreen': (context) => ProfileScreen(),
        '/pie': (context) => PieChartScreen(),

        '/homeScreenBusiness': (context) => HomeScreenBusiness(),
        '/mainScreenBusiness': (context) => MainScreenBusiness(),
        '/stateScreenBusiness': (context) => StatScreenBusiness(),
        '/pieBusiness': (context) => PieChartScreenBusiness(),






      },

      home: const MainPage(),
    );
  }
}
