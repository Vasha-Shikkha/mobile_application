import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/fill_in_the_blanks_view.dart';
import 'package:Vasha_Shikkha/ui/find_error/find_error_view.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';
import 'package:Vasha_Shikkha/ui/jumbled_sentence/jumbled_sentence_view.dart';
import 'package:Vasha_Shikkha/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/mcq/multiple_choice_view.dart';

final routes = {
  '/login': (BuildContext context) => LoginScreen(),
  HomeScreen.id: (BuildContext context) => HomeScreen(),
  '/multiple-choice': (BuildContext context) => MultipleChoiceView(),
  '/fill-in-the-blanks': (BuildContext context) => FillInTheBlanksView(),
  '/find-error': (BuildContext context) => FindErrorView(),
  '/jumbled-sentence': (BuildContext context) => JumbledSentenceView(),
};
