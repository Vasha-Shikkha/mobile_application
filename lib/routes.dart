import 'package:Vasha_Shikkha/ui/flashcard/flashcard.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';
import 'package:Vasha_Shikkha/ui/home/landing_screen.dart';
import 'package:Vasha_Shikkha/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

final routes = {
  LandingScreen.route: (BuildContext context) => LandingScreen(),
  LoginScreen.route: (BuildContext context) => LoginScreen(),
  HomeScreen.route: (BuildContext context) => HomeScreen(),
  Flashcard.route: (BuildContext context) => Flashcard(),
};
