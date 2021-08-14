import 'package:Vasha_Shikkha/data/models/js.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:Vasha_Shikkha/ui/drag/drag_target_blank.dart';
import 'package:Vasha_Shikkha/ui/drag/draggable_option.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class JumbledSentenceView extends StatefulWidget {
  static const String route = '/jumbled-sentence';
  final List<JS> subtasks;

  const JumbledSentenceView({Key key, @required this.subtasks})
      : super(key: key);

  @override
  _JumbledSentenceViewState createState() => _JumbledSentenceViewState();
}

class _JumbledSentenceViewState extends State<JumbledSentenceView>
    with ExerciseMixin {
  int _currentSubtask;
  Map<int, String> _blankData;
  List<DraggableOption> _optionWidgets;
  List<DragTargetBlank> _blanks;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _blankData = {};
    _optionWidgets = [];
    _blanks = [];
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

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Jumbled Sentence",
      subtaskCount: widget.subtasks.length,
      instruction: widget.subtasks.elementAt(_currentSubtask).instruction,
      onCheck: () {
        bool correct = true;
        List<String> answers =
            widget.subtasks.elementAt(_currentSubtask).answer;
        for (int i = 0; i < answers.length; i++) {
          if (answers
                  .elementAt(i)
                  .toLowerCase()
                  .compareTo(_blankData[i]?.toLowerCase() ?? '') !=
              0) {
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
          _buildOptions();
          _buildBlanks();
        });
      },
      onContinue: () {
        if (_currentSubtask + 1 < widget.subtasks.length) {
          setState(() {
            _currentSubtask++;
            _blankData = {};
            _buildOptions();
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
              Wrap(
                alignment: WrapAlignment.center,
                children: _optionWidgets,
              ),
              SizedBox(
                height: 40,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: _blanks,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildBlanks() {
    List<String> words = widget.subtasks.elementAt(_currentSubtask).answer;
    _blanks.clear();
    for (int i = 0; i < words.length; i++) {
      _blanks.add(DragTargetBlank(
        serial: i,
        updateBlankData: _updateBlankData,
      ));
      _blankData[i] = null;
    }
  }

  void _buildOptions() {
    List<String> words = widget.subtasks.elementAt(_currentSubtask).chunks;
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
