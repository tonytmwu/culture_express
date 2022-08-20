import 'package:flutter/material.dart';

class PrimaryTheme {
  static const MaterialColor primaryBlue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFF0abab5),
      100: Color(0xFF0abab5),
      200: Color(0xFF0abab5),
      300: Color(0xFF0abab5),
      400: Color(0xFF0abab5),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF0abab5),
      700: Color(0xFF0abab5),
      800: Color(0xFF0abab5),
      900: Color(0xFF0abab5),
    },
  );

  static const int _bluePrimaryValue = 0xFF0abab5;
}