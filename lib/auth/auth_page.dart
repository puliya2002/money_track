import 'package:money_track/pages/login_page.dart';
import 'package:money_track/pages/register_page.dart';
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
      return LoginPage(showRegisterPage: toggleScreens);
    }else{
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}