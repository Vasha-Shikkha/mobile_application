import 'package:Vasha_Shikkha/data/db/token.dart';
import 'package:Vasha_Shikkha/data/models/token.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';
import 'package:Vasha_Shikkha/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class LandingScreen extends StatefulWidget {
  static final String route = '/landing';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<void> _checkLoginStatus() async {
    String route;
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // if offline, show home with locally downloaded data
      route = HomeScreen.route;
    } else {
      Token token = await TokenDatabaseHelper().getToken();
      if (token == null) {
        route = LoginScreen.route;
      } else {
        DateTime expiryDate = DateTime.parse(token.expiryDate);
        if (expiryDate.isBefore(DateTime.now())) {
          // if token has expired, show login screen
          route = LoginScreen.route;
        } else {
          // continue to home with existing token
          route = HomeScreen.route;
        }
      }
    }
    Future.delayed(
      Duration(seconds: 1),
      () => Navigator.of(context).pushReplacementNamed(route),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColorDark,
            Theme.of(context).accentColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Vasha Shikkha',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
