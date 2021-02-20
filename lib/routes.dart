import 'package:Vasha_Shikkha/ui/fb/fill_in_the_blanks_view.dart';
import 'package:Vasha_Shikkha/ui/login/login_screen.dart';
import 'package:Vasha_Shikkha/ui/mcq/mcq_screen.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (BuildContext context) => LoginScreen(),
  '/mcq': (BuildContext context) => McqScreen(),
  '/fb': (BuildContext context) => FillInTheBlanksView(),
};
