import 'package:flutter/material.dart';

ThemeData customThemeData = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColorDark: Color(0xFF9E63FF),
  primaryColorLight: Color(0xFFCEAFFF),
  accentColor: Color(0xFFFFB8B8),
  textTheme: TextTheme(
    button: TextStyle(
      fontWeight: FontWeight.w500,
    ),
  ),
);
