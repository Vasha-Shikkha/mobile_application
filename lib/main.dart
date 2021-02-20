import 'package:Vasha_Shikkha/data/moor_database.dart';
import 'package:Vasha_Shikkha/routes.dart';
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
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Avenir',
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        initialRoute: '/fb',
      ),
    );
  }
}
