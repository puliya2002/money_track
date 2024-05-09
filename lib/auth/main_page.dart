import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_track/screens/home_screen.dart';
import 'package:money_track/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../provider/business_personal_provider.dart';
import '../screens_business/home_screen_business.dart';
import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<SwitchProvider>(
                builder: (context, switchProvider, _) {
                  if (switchProvider.isBusiness) {
                    return HomeScreenBusiness();
                  } else {
                    return HomeScreen();
                  }
                },
              );
            } else {
              return AuthPage();
            }
          }),
    );
  }
}
