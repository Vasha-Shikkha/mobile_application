import 'package:Vasha_Shikkha/ui/flashcard/flashcard.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';
import 'package:Vasha_Shikkha/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (BuildContext context) => LoginScreen(),
  HomeScreen.id: (BuildContext context) => HomeScreen(),
  Flashcard.route: (BuildContext context) => Flashcard(),
};
