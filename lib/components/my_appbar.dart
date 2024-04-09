import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,

        title: Image.asset("assets/Logo.png", height: 45,),
        centerTitle: true,


    );
  }
}