import 'package:flutter/material.dart';
import 'package:vasha_shikkha/ui/base/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
