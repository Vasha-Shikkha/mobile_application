import 'package:flutter/material.dart';

class DragTargetBlank extends StatefulWidget {
  @override
  _DragTargetBlankState createState() => _DragTargetBlankState();
}

class _DragTargetBlankState extends State<DragTargetBlank> {
  bool empty = true;
  String placedText = "";

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> candidateData,
          List rejectedData) {
        return Container(
          // color: Colors.purple.shade100,
          width: 100,
          height: 100,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: (placedText == null || placedText.isEmpty)
                ? Divider(
                    color: Colors.black,
                    thickness: 2,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Chip(
                            label: Text(placedText),
                            labelPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            elevation: 10.0,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ],
                  ),
          ),
        );
      },
      onWillAccept: (String data) {
        print(data);
        return true;
      },
      onAccept: (String data) {
        setState(() {
          placedText = data;
          empty = false;
        });
      },
    );
  }
}
