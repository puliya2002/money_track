import 'package:money_track/screens/login_screen.dart';
import 'package:money_track/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  bool showLoginPage = true;
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginScreen(showRegisterPage: toggleScreens);
    }else{
      return RegisterScreen(showLoginPage: toggleScreens);
    }
  }
}