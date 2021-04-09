import 'package:vasha_shikkha/ui/base/exercise_screen.dart';
import 'package:vasha_shikkha/ui/fb/widgets/drag_target_blank.dart';
import 'package:vasha_shikkha/ui/fb/widgets/draggable_option.dart';
import 'package:flutter/material.dart';

class FillInTheBlanksView extends StatefulWidget {
  final String sentence =
      "A  vehicle is # to move people and things. A vehicle is not #.";

  @override
  _FillInTheBlanksViewState createState() => _FillInTheBlanksViewState();
}

class _FillInTheBlanksViewState extends State<FillInTheBlanksView> {
  List<String> options = ['fair', 'hospital', 'candies', 'doctor', 'teacher'];

  List<Widget> _buildSentenceWidgets() {
    List<Widget> widgets = [];
    List<String> articles = ["a", "an", "the"];
    List<String> punctuation = [",", ".", ";", "?", "!", ":"];

    int startIndex = 0;
    int index = widget.sentence.indexOf("#");
    String sentence = "";
    while (index >= 0) {
      sentence += widget.sentence.substring(startIndex, index);
      sentence += " # ";
      startIndex = index + 1;
      index = widget.sentence.indexOf("#", startIndex);
    }
    sentence += widget.sentence.substring(startIndex);

    List<String> words = sentence.split(" ");

    words.forEach((word) {
      if (word.contains("#")) {
        widgets.add(DragTargetBlank());
      } else if (articles.contains(word.toLowerCase()) ||
          punctuation.contains(word)) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '$word ',
          ),
        ));
      } else {
        // TODO: show meaning
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '$word ',
          ),
        ));
      }
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Fill in the blanks",
      onCheck: () {
        // TODO: handle check
      },
      exercise: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                children: _buildSentenceWidgets(),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: options
                  .map<DraggableOption>(
                    (option) => DraggableOption(
                      text: option,
                      renderKey: GlobalKey(),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
