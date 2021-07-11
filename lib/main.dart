import 'package:Vasha_Shikkha/routes.dart';
import 'package:Vasha_Shikkha/style/custom_theme.dart';
import 'package:Vasha_Shikkha/ui/home/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return LandingScreen();
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vasha Shikkha',
            theme: customThemeData,
            routes: routes,
            initialRoute: LandingScreen.route,
          );
        }
      },
    );
  }
}
