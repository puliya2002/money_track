import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({super.key, required this.showLoginPage});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {




  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  bool passwordConfirmed(){
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
    }else
      return false;
  }





  Future signUp() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordConfirmed()) {
        // Create user with email and password
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the Firebase User object
        User? user = userCredential.user;

        if (user != null) {
          // Add user details to Firestore using user UID as document ID
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid) // Use UID as document ID
              .set({
            'first name': _nameController.text.trim(),
            'email': _emailController.text.trim(),
            'remainingAmount': 0,
            'totalCredit': 0,
            'totalDebit': 0,
            'joinedDate': DateTime.now(),
          });

          // Dismiss loading indicator
          Navigator.pop(context);
        } else {
          // Dismiss loading indicator
          Navigator.pop(context);
          // Handle null user
          print('User creation failed.');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('User creation failed.'),
              );
            },
          );
        }
      } else {
        // Dismiss loading indicator
        Navigator.pop(context);
        // Handle password mismatch
        print('The password and confirm password do not match.');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('The password and confirm password do not match.'),
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      // Dismiss loading indicator
      Navigator.pop(context);
      // Handle FirebaseAuth exceptions
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('The password provided is too weak.'),
            );
          },
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('The account already exists for that email.'),
            );
          },
        );
      } else {
        print('Error: ${e.message}');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Error: ${e.message}'),
            );
          },
        );
      }
    } catch (e) {
      // Dismiss loading indicator
      Navigator.pop(context);
      // Handle other exceptions
      print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('An error occurred: $e'),
          );
        },
      );
    }
  }

  // Future signUp() async {
  //
  //   //loading Circle
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  //
  //   try {
  //     if (passwordConfirmed() == true){
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //
  //
  //       //add user name
  //       addUserDetails( _nameController.text.trim(), _emailController.text.trim(),);
  //
  //
  //
  //       //stop loading circle after loading
  //       Navigator.pop(context);
  //
  //
  //     } else {
  //       //stop loading circle after loadinghb
  //       Navigator.pop(context);
  //
  //       print('The password provided is too weak.');
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text('New password and confirm password do not match'),
  //           );
  //         },
  //       );
  //
  //     }
  //
  //
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //
  //       //stop loading circle after loading
  //       Navigator.pop(context);
  //
  //       print('The password provided is too weak.');
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text('The password provided is too weak.'),
  //           );
  //         },
  //       );
  //     } else if (e.code == 'email-already-in-use') {
  //
  //       //stop loading circle after loading
  //       Navigator.pop(context);
  //
  //       print('The account already exists for that email.');
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text('The account already exists for that email.'),
  //           );
  //         },
  //       );
  //     } else{
  //       //stop loading circle after loading
  //       Navigator.pop(context);
  //
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text('Invalid email or password'),
  //           );
  //         },
  //       );
  //
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //
  //
  // }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
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
              SizedBox(
                height: 20,
              ),
              Text(
                'Hello!!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
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
                          height: 26,
                        ),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                    controller: _nameController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Name',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: double.infinity,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 30,
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
                                    decoration: InputDecoration(
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: double.infinity,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow:  [
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(

                                      border: InputBorder.none,
                                      hintText: 'Confirm Password',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: signUp,
                            child: Container(
                              width: double.infinity,
                              height: 65,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20,
                                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                                      offset: Offset(2, 5))
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign Up',
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
                          height: 30,
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
                                  "Already have an Account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: widget.showLoginPage,
                                    // (){
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                                    //
                                    // },
                                    child: Text(
                                      'Sign In',
                                    )),
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
