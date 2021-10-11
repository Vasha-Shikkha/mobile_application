import 'package:flutter/material.dart';

ThemeData customThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColorDark: Colors.deepPurple,
  primaryColorLight: Colors.purple,
  accentColor: Colors.pink.shade50,
  errorColor: Colors.redAccent.shade400,
  disabledColor: Colors.purple.shade50,

  // primaryColorDark: Color(0xFF9E63FF),
  // primaryColorLight: Color(0xFFCEAFFF),
  // accentColor: Color(0xFFFFB8B8),
  scrollbarTheme: ScrollbarThemeData(
    trackColor: MaterialStateProperty.all(Color(0xFF9E63FF)),
    thumbColor: MaterialStateProperty.all(Color(0xFFFFB8B8)),
  ),
  textTheme: TextTheme(
    button: TextStyle(
      fontWeight: FontWeight.w500,
    ),
  ),
);
