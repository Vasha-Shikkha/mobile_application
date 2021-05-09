import 'package:vasha_shikkha/data/moor_database.dart';
import 'package:vasha_shikkha/routes.dart';
import 'package:vasha_shikkha/style/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vasha_shikkha/ui/home/home_screen.dart';
import 'package:vasha_shikkha/ui/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TokensDao>(
          create: (context) => MoorDatabase().tokensDao,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vasha Shikkha',
        theme: customThemeData,
        routes: routes,
        initialRoute: '/login',
      ),
    );
  }
}
