import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFf3f6f9),

    onBackground: Color(0xFF363636),


    primary: Color(0xFF2291fd),
    secondary: Color(0xFF6dd2ff),
    primaryContainer: Colors.white,
    secondaryContainer: Color(0xFF363636),
    shadow: Color(0xFF2291fd),


  ),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      onBackground: Color(0xFFdedede),

      primary: Color(0xFF015eea),
      secondary: Color(0xFF009ffa),
      primaryContainer: Color(0xFF383838),
      secondaryContainer: Colors.black,
      shadow: Color(0xFF000046).withOpacity(0.5),
    )

);

