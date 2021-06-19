import 'package:Vasha_Shikkha/data/models/js.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/drag_target_blank.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/draggable_option.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class WM {
  int wmId;
  String question;
  List<String> left;
  List<String> right;
  String explanation;

  WM({
    @required this.wmId,
    @required this.question,
    @required this.left,
    @required this.right,
    @required this.explanation,
  });
}

class WordMatchingView extends StatefulWidget {
  static const String route = '/word-matching';
  final List<WM> subtasks = [
    WM(
      wmId: 1,
      question: "Match the verbs with appropriate adverbs",
      left: ["speak", "walk", "eat", "sleep", "live"],
      right: ["softly", "quickly", "slowly", "peacefully", "fully"],
      explanation: "",
    ),
  ];

  // const WordMatchingView({Key key, @required this.subtasks}) : super(key: key);

  @override
  _WordMatchingViewState createState() => _WordMatchingViewState();
}

class _WordMatchingViewState extends State<WordMatchingView>
    with ExerciseMixin {
  int _currentSubtask;
  Map<int, String> _blankData;
  List<DragTargetBlank> _blanks;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _blankData = {};
    _buildBlanks();
  }

  void _updateBlankData(int serial, String text) {
    _blankData[serial] = text;
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Jumbled Sentence",
      subtaskCount: widget.subtasks.length,
      initialSubtask: 0, // TODO: should be last attempted
      onCheck: () {
        bool correct = true;
        List<String> answers = widget.subtasks.elementAt(_currentSubtask).right;
        for (int i = 0; i < answers.length; i++) {
          if (answers.elementAt(i).compareTo(_blankData[i] ?? '') != 0) {
            correct = false;
          }
        }
        print(answers);
        print(_blankData);
        return correct;
      },
      onContinue: () {
        if (_currentSubtask + 1 < widget.subtasks.length) {
          setState(() {
            _currentSubtask++;
            _blankData = {};
            _buildBlanks();
          });
        } else {
          showAnimatedDialog(
            context: context,
            animationType: DialogTransitionType.fadeScale,
            builder: (context) => ClassicGeneralDialogWidget(
              titleText: 'Task Complete!',
              contentText: 'You have attempted all the questions in this task.',
              onNegativeClick: null,
              positiveText: 'OK',
              onPositiveClick: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          );
        }
      },
      onExplain: () => onExplain(
        context,
        widget.subtasks.elementAt(_currentSubtask).explanation,
      ),
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
                  widget.subtasks.elementAt(_currentSubtask).question,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: _buildOptions(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8,
                  );
                },
                itemCount:
                    widget.subtasks.elementAt(_currentSubtask).left.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          widget.subtasks
                              .elementAt(_currentSubtask)
                              .left[index],
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      // SizedBox(
                      //   width: 16,
                      // ),
                      // Divider(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: _blanks[index],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildBlanks() {
    List<String> words = widget.subtasks.elementAt(_currentSubtask).right;
    _blanks = [];
    for (int i = 0; i < words.length; i++) {
      _blanks.add(DragTargetBlank(
        serial: i,
        updateBlankData: _updateBlankData,
      ));
      _blankData[i] = null;
    }
  }

  List<DraggableOption> _buildOptions() {
    List<String> words =
        widget.subtasks.elementAt(_currentSubtask).right.toList();
    words.shuffle();
    return words
        .map<DraggableOption>(
          (option) => DraggableOption(
            text: option,
            renderKey: GlobalKey(),
          ),
        )
        .toList();
  }
}
