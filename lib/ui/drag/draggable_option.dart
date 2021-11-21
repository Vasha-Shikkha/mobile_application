import 'package:flutter/material.dart';

class DraggableOption extends StatefulWidget {
  final String text;
  final int optionSerial;
  final GlobalKey renderKey;

  const DraggableOption(
      {Key key,
      @required this.text,
      @required this.optionSerial,
      @required this.renderKey})
      : super(key: key);

  @override
  _DraggableOptionState createState() => _DraggableOptionState();
}

class _DraggableOptionState extends State<DraggableOption> {
  bool available = true;
  double width;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    available = true;
  }

  _afterLayout(_) {
    final RenderBox renderBox =
        widget.renderKey.currentContext.findRenderObject();
    width = renderBox.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return available
        ? Draggable<Map<String, dynamic>>(
            key: widget.renderKey,
            data: {
              'text': widget.text,
              'optionSerial': widget.optionSerial,
              'renderKey': widget.renderKey,
            },
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  child: Chip(
                    label: Text(
                      widget.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
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
                  label: Text(widget.text),
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  elevation: 10.0,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            childWhenDragging: _buildDisabledChip(),
            onDragCompleted: () {
              setState(() {
                available = false;
              });
            },
          )
        : _buildEmptyOption();
  }

  DragTarget<Map<String, dynamic>> _buildEmptyOption() {
    return DragTarget<Map<String, dynamic>>(
      builder: (BuildContext context, List<Map<String, dynamic>> candidateData,
          List rejectedData) {
        return _buildDisabledChip();
      },
      onWillAccept: (Map<String, dynamic> data) {
        return data['text'] == widget.text;
      },
      onAccept: (Map<String, dynamic> data) {
        print('accept');
        setState(() {
          available = true;
        });
      },
    );
  }

  Material _buildDisabledChip() {
    Color textColor = Colors.grey.shade600;
    Color chipColor = Colors.grey.shade400;
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Chip(
          label: Text(
            widget.text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
            ),
          ),
          labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
          elevation: 10.0,
          backgroundColor: chipColor,
        ),
      ),
    );
  }
}
