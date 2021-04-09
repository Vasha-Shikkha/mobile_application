import 'package:vasha_shikkha/ui/fb/fill_in_the_blanks_view.dart';
import 'package:vasha_shikkha/ui/home/home_screen.dart';
import 'package:vasha_shikkha/ui/login/login_screen.dart';
import 'package:vasha_shikkha/ui/mcq/mcq_screen.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (BuildContext context) => LoginScreen(),
  HomeScreen.id: (BuildContext context) => HomeScreen(),
  '/mcq': (BuildContext context) => McqScreen(),
  '/fb': (BuildContext context) => FillInTheBlanksView(),
};
