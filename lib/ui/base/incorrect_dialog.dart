import 'package:flutter/material.dart';

class IncorrectDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: BottomSheet(
        backgroundColor: Colors.red.shade200,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.redAccent.shade400,
                        child: Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Incorrect!",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.redAccent.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text("Some sort of explanation"),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildContinueButton(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ElevatedButton _buildContinueButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 30),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.redAccent.shade400),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(5.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        shadowColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorDark),
      ),
      child: Text('Continue'),
      onPressed: () {},
    );
  }
}