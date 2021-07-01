import 'package:flutter/material.dart';

class DragTargetBlank extends StatefulWidget {
  final int serial;
  final Function updateBlankData;

  const DragTargetBlank(
      {Key key, @required this.serial, @required this.updateBlankData})
      : super(key: key);
  @override
  _DragTargetBlankState createState() => _DragTargetBlankState();
}

class _DragTargetBlankState extends State<DragTargetBlank> {
  bool empty = true;
  Map<String, dynamic> placedData;
  double width = 80;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    empty = true;
    placedData = null;
    width = 80;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      builder: (BuildContext context, List<Map<String, dynamic>> candidateData,
          List rejectedData) {
        return Container(
          alignment: Alignment.centerLeft,
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
          width = renderBox.size.width + 24;
          widget.updateBlankData(
              widget.serial, data['optionSerial'], placedData['text']);
        });
      },
    );
  }

  Widget _buildPlacedOption() {
    // return Draggable<Map<String, dynamic>>(
    //   data: {
    //     'text': placedData['text'],
    //     'renderKey': placedData['renderKey'],
    //   },
    //   child:
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
          onLongPress: () {
            print('long press ${placedData['text']}');
            setState(() {});
          },
          child: Chip(
            deleteIconColor: Theme.of(context).accentColor,
            onDeleted: () {
              print('deleted ${placedData['text']}');
              setState(() {
                empty = true;
                width = 80;
                widget.updateBlankData(
                    widget.serial, placedData['optionSerial'], null);
                placedData = null;
              });
            },
            label: Text(placedData['text']),
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
            elevation: 10.0,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
    //   childWhenDragging: Container(),
    //   feedback: Material(
    //     color: Colors.transparent,
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 10.0),
    //       child: Chip(
    //         label: Text(placedData['text']),
    //         labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
    //         elevation: 10.0,
    //         backgroundColor: Colors.white,
    //       ),
    //     ),
    //   ),
    //   onDragCompleted: () {
    //     setState(() {
    //       empty = true;
    //       width = 80;

    //       widget.updateBlankData(
    //           widget.serial, placedData['optionSerial'], null);
    //       placedData = null;
    //     });
    // },
    // );
  }
}
