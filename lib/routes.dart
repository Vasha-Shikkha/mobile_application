import 'package:Vasha_Shikkha/ui/flashcard/flashcard.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';
import 'package:Vasha_Shikkha/ui/login/login_screen.dart';
import 'package:Vasha_Shikkha/ui/picture_to_word/picture_to_word_view.dart';
import 'package:Vasha_Shikkha/ui/word_to_picture/word_to_picture_view.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (BuildContext context) => LoginScreen(),
  HomeScreen.id: (BuildContext context) => HomeScreen(),
  PictureToWordView.route: (BuildContext context) => PictureToWordView(),
  WordToPictureView.route: (BuildContext context) => WordToPictureView(),
  Flashcard.route: (BuildContext context) => Flashcard(),
};
