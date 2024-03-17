import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_track/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'foget_password.dart';



class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    //loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });


    try {
      //Sign In

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      //stop loading circle after loading
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      //stop loading circle after loadinghb
      Navigator.pop(context);

      String errorMessage = "An unexpected error occurred. Wrong email or password. Please try again.";

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }

      print('Firebase Auth Exception: ${e.code} - ${e.message}');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
          );
        },
      );
    } catch (e) {
      //stop loading circle after loadinghb
      Navigator.pop(context);

      print('Unexpected error: $e');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Wrong email or password"),
          );
        },
      );
    }



  }

  // void wrongEmailMessage(){
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('No user found for that email.'),
  //       );
  //     },
  //   );
  // }
  //
  // void wrongPasswordMessage(){
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Wrong password provided for that user.'),
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                'Hello Again!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ],
                      transform: const GradientRotation(pi / 3),
                    ),

                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Container(
                            width: double.infinity,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    color: Color(0XFF2d99e3).withOpacity(0.4),
                                    offset: Offset(2, 5))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Container(
                            width: double.infinity,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    color: Color(0XFF2d99e3).withOpacity(0.4),
                                    offset: Offset(2, 5))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return ForgetPasswordPage();
                                      }));
                                },
                                child: Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: signIn,
                            child: Container(
                              width: double.infinity,
                              height: 65,
                              decoration: BoxDecoration(
                                color:
                                Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 30,
                                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                                      offset: Offset(2, 5))
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                  ),
                                ),
                                Image.asset(
                                  "assets/facebook1.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                  ),
                                ),
                                Image.asset(
                                  "assets/google1.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Don't Have an Account?",
                                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: widget.showRegisterPage,
                                  // (){
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()),);
                                  //
                                  // },
                                  child: Text(
                                    'Sign Up',

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          "assets/logowhite2.png",
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
