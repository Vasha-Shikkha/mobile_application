import 'dart:math';

import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  static const String route = '/flashcard';
  final String meaning =
      "A word having the same or almost the same meaning as another word";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 4,
            backgroundColor: Color(0xFFFFB8B8),
            child: IconButton(
              padding: EdgeInsets.all(0),
              iconSize: 20,
              color: Colors.white,
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Text(
          "FLASH CARDS",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 8.0,
        ),
        child: ElevatedButton(
          child: Text(
            "Next",
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColorLight),
            foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
            elevation: MaterialStateProperty.all(5.0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            shadowColor:
                MaterialStateProperty.all(Theme.of(context).primaryColorDark),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Transform.rotate(
              angle: -pi / 8,
              child: Card(
                elevation: 10,
                color: Colors.white,
                shadowColor: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Transform.rotate(
              angle: -pi / 16,
              child: Card(
                elevation: 10,
                color: Colors.white,
                shadowColor: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              shadowColor: Theme.of(context).primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SYNONYM",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    Divider(
                      indent: 48,
                      endIndent: 48,
                      height: 4,
                      thickness: 2,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      meaning,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
