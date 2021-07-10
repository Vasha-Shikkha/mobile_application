import 'package:Vasha_Shikkha/data/models/sm.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/drag_target_blank.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/draggable_option.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class WordMatchingView extends StatefulWidget {
  static const String route = '/word-matching';

  final SMList subtasks;
  // final List<SM> subtasks;
  // final List<WM> subtasks = [
  //   WM(
  //     wmId: 1,
  //     question: "Match the verbs with appropriate adverbs",
  //     left: ["speak", "walk", "eat", "sleep", "live"],
  //     right: ["softly", "quickly", "slowly", "peacefully", "fully"],
  //     explanation: "",
  //   ),
  // ];

  const WordMatchingView({Key key, @required this.subtasks}) : super(key: key);

  @override
  _WordMatchingViewState createState() => _WordMatchingViewState();
}

class _WordMatchingViewState extends State<WordMatchingView>
    with ExerciseMixin {
  int _currentSubtask;
  Map<int, String> _blankData;
  List<DragTargetBlank> _blanks;
  List<DraggableOption> _optionWidgets;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _blankData = {};
    _optionWidgets = [];
    _buildOptions();
    _buildBlanks();
  }

  void _updateBlankData(int blankSerial, int optionSerial, String text) {
    final currentText = _optionWidgets[optionSerial].text;
    final renderKey = _optionWidgets[optionSerial].renderKey;
    _blankData[blankSerial] = text;
    if (text == null) {
      setState(() {
        print("hello $currentText $text");
        _optionWidgets[optionSerial] = DraggableOption(
          text: currentText,
          optionSerial: optionSerial,
          renderKey: renderKey,
        );
        print(_blankData);
      });
    }
  }

  String _buildExplanation() {
    String explanation = "";
    List<String> parts = widget.subtasks
        .getParts(widget.subtasks.smList)['Explanations']
        .toList();
    for (int i = 0; i < parts.length; i++) {
      explanation += (i + 1).toString() + ") ";
      explanation += parts[i] + "\n";
    }
    return explanation;
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Word Matching",
      subtaskCount: 1,
      initialSubtask: 0, // TODO: should be last attempted
      onCheck: () {
        bool correct = true;
        List<String> answers = widget.subtasks
            .getParts(widget.subtasks.smList)['PartTwo']
            .toList();
        for (int i = 0; i < answers.length; i++) {
          if (answers.elementAt(i).compareTo(_blankData[i] ?? '') != 0) {
            correct = false;
          }
        }
        print(answers);
        print(_blankData);
        return correct;
      },
      onReset: () {
        setState(() {
          _blankData = {};
          _buildBlanks();
          _buildOptions();
        });
      },
      onContinue: () {
        if (_currentSubtask + 1 < 1) {
          setState(() {
            _currentSubtask++;
            _blankData = {};
            _buildBlanks();
            _buildOptions();
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
        _buildExplanation(),
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
                  "Take words from the box and match with related words",
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
                  children: _optionWidgets,
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
                itemCount: widget.subtasks.smList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          widget.subtasks
                              .getParts(widget.subtasks.smList)['PartOne']
                              .toList()[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
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
    List<String> words =
        widget.subtasks.getParts(widget.subtasks.smList)['PartTwo'].toList();
    _blanks = [];
    for (int i = 0; i < words.length; i++) {
      _blanks.add(DragTargetBlank(
        serial: i,
        updateBlankData: _updateBlankData,
      ));
      _blankData[i] = null;
    }
  }

  void _buildOptions() {
    List<String> words =
        widget.subtasks.getParts(widget.subtasks.smList)['PartTwo'].toList();
    words.shuffle();
    _optionWidgets.clear();
    for (int i = 0; i < words.length; i++) {
      _optionWidgets.add(
        DraggableOption(
          text: words.elementAt(i),
          optionSerial: i,
          renderKey: GlobalKey(),
        ),
      );
    }
  }
}
