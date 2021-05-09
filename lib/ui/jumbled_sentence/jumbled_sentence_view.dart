import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/drag_target_blank.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/draggable_option.dart';

class JumbledSentenceView extends StatefulWidget {
  @override
  _JumbledSentenceViewState createState() => _JumbledSentenceViewState();
}

class _JumbledSentenceViewState extends State<JumbledSentenceView> {
  final String _sentence =
      "I love tasting different seasonal fruits throughout the year";
  List<String> _jumbledWords;

  void _jumbleSentence() {
    _jumbledWords = _sentence.split(" ");
    _jumbledWords.shuffle();
  }

  @override
  void initState() {
    super.initState();
    _jumbleSentence();
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Jumbled Sentence",
      onCheck: () {},
      exercise: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 20),
                child: Text(
                  "Arrange the words to form a sentence",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: _jumbledWords
                    .map<DraggableOption>(
                      (option) => DraggableOption(
                        text: option,
                        renderKey: GlobalKey(),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 40,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: _jumbledWords.map((e) => DragTargetBlank()).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
