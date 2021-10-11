import 'package:Vasha_Shikkha/ui/flashcard/flashcard.dart';
import 'package:Vasha_Shikkha/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';

class BottomNavbar extends StatelessWidget {
  /*
    returns true if the current route is route, false otherwise
  */
  bool _checkIfSameRoute(BuildContext context, String route) {
    Route currentRoute = ModalRoute.of(context);
    final currentRouteName = currentRoute?.settings?.name;
    return (currentRouteName != null && currentRouteName == route);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AppbarPainter(),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                iconSize: 30,
                color: Theme.of(context).primaryColorLight,
                onPressed: () {
                  if (!_checkIfSameRoute(context, Flashcard.route)) {
                    Navigator.of(context).pushNamed(Flashcard.route);
                  }
                },
                icon: Icon(Icons.library_books_outlined),
                tooltip: "flash cards",
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Material(
                shape: CircleBorder(),
                color: Colors.transparent,
                elevation: 8,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  radius: 24,
                  child: IconButton(
                    iconSize: 32,
                    color: Colors.white,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      if (!_checkIfSameRoute(context, HomeScreen.route)) {
                        Navigator.of(context).pushNamed(HomeScreen.route);
                      }
                    },
                    icon: Icon(Icons.home),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 30,
                color: Theme.of(context).primaryColorLight,
                onPressed: () {
                  if (!_checkIfSameRoute(context, ProfileScreen.route)) {
                    Navigator.of(context).pushNamed(ProfileScreen.route);
                  }
                },
                icon: Icon(Icons.person_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppbarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = new Paint()
      ..color = Color(0xFFFFF0FF)
      ..style = PaintingStyle.fill;

    Path path = Path();

    RRect r = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width - 50,
        height: 50,
      ),
      Radius.circular(16),
    );

    path.addRRect(r);
    path.addArc(
      Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.5 - 24),
          width: 70,
          height: 70),
      0,
      180,
    );

    canvas.drawShadow(
      path,
      Colors.grey,
      4,
      true,
    );
    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
    throw UnimplementedError();
  }
}
