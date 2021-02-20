import 'package:flutter/material.dart';

class DraggableOption extends StatelessWidget {
  final String text;

  const DraggableOption({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: text,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onLongPress: () {
              print('long press $text');
            },
            child: Chip(
              label: Text(text),
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              elevation: 10.0,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      feedback: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Chip(
            label: Text(text),
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
            elevation: 10.0,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      childWhenDragging: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Chip(
            label: Text(
              text,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
            elevation: 10.0,
            backgroundColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
