import 'package:flutter/material.dart';

class DragTargetBlank extends StatefulWidget {
  @override
  _DragTargetBlankState createState() => _DragTargetBlankState();
}

class _DragTargetBlankState extends State<DragTargetBlank> {
  bool empty = true;
  Map<String, dynamic> placedData;
  double width = 80;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      builder: (BuildContext context, List<Map<String, dynamic>> candidateData,
          List rejectedData) {
        return Container(
          width: width,
          height: 50,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: empty
                ? Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 1,
                    indent: 2,
                    endIndent: 2,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildPlacedOption(),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 1,
                        indent: 2,
                        endIndent: 2,
                      ),
                    ],
                  ),
          ),
        );
      },
      onWillAccept: (Map<String, dynamic> data) {
        print(data);
        return empty;
      },
      onAccept: (Map<String, dynamic> data) {
        setState(() {
          placedData = data;
          empty = false;
          final RenderBox renderBox =
              data['renderKey'].currentContext.findRenderObject();
          width = renderBox.size.width;
        });
      },
    );
  }

  Draggable<Map<String, dynamic>> _buildPlacedOption() {
    return Draggable<Map<String, dynamic>>(
      data: {
        'text': placedData['text'],
        'renderKey': placedData['renderKey'],
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onLongPress: () {
              print('long press ${placedData['text']}');
            },
            child: Chip(
              label: Text(placedData['text']),
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              elevation: 10.0,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      childWhenDragging: Container(),
      feedback: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Chip(
            label: Text(placedData['text']),
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
            elevation: 10.0,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      onDragCompleted: () {
        setState(() {
          empty = true;
          width = 80;
          placedData = null;
        });
      },
    );
  }
}
