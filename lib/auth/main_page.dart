import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../provider/business_personal_provider.dart';
import '../screens/business/home_screen_business.dart';
import '../screens/personal/home_screen.dart';
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
