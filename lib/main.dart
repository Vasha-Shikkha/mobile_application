import 'package:Vasha_Shikkha/data/moor_database.dart';
import 'package:Vasha_Shikkha/routes.dart';
import 'package:Vasha_Shikkha/style/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        initialRoute: '/fb',
      ),
    );
  }
}
