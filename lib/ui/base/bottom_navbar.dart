import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: AppbarPainter(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  iconSize: 30,
                  color: Colors.purple,
                  onPressed: () {},
                  icon: Icon(Icons.menu_book),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Material(
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  elevation: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 24,
                    child: IconButton(
                      iconSize: 32,
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.home),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 30,
                  color: Colors.purple,
                  onPressed: () {},
                  icon: Icon(Icons.person_outline),
                ),
              ),
            ],
          ),
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
