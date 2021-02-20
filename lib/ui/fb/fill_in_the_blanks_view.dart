import 'package:Vasha_Shikkha/ui/fb/widgets/drag_target_blank.dart';
import 'package:Vasha_Shikkha/ui/fb/widgets/draggable_option.dart';
import 'package:flutter/material.dart';

class FillInTheBlanksView extends StatefulWidget {
  @override
  _FillInTheBlanksViewState createState() => _FillInTheBlanksViewState();
}

class _FillInTheBlanksViewState extends State<FillInTheBlanksView> {
  List<String> options = ['fair', 'hospital', 'candies', 'doctor', 'teacher'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DragTargetBlank(),
            SizedBox(
              height: 100,
            ),
            Wrap(
              children: options
                  .map<DraggableOption>((option) => DraggableOption(
                        text: option,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
