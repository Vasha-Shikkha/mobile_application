import 'package:Vasha_Shikkha/data/models/js.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/drag_target_blank.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/widgets/draggable_option.dart';
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

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _blankData = {};
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
        List<String> answers = widget.subtasks
            .elementAt(_currentSubtask)
            .sentence
            .toString()
            .split(" ");
        for (int i = 0; i < answers.length; i++) {
          if (answers.elementAt(i).compareTo(_blankData[i] ?? '') != 0) {
            correct = false;
          }
        }
        print(_blankData);
        return correct;
      },
      onReset: () {
        setState(() {
          _blankData = {};
        });
      },
      onContinue: () {
        if (_currentSubtask + 1 < widget.subtasks.length) {
          setState(() {
            _currentSubtask++;
            _blankData = {};
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
                children: _buildOptions(),
              ),
              SizedBox(
                height: 40,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: _buildBlanks(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DragTargetBlank> _buildBlanks() {
    List<String> words = widget.subtasks
        .elementAt(_currentSubtask)
        .sentence
        .toString()
        .split(" ");
    List<DragTargetBlank> blanks = [];
    for (int i = 0; i < words.length; i++) {
      blanks.add(DragTargetBlank(
        serial: i,
        updateBlankData: _updateBlankData,
      ));
      _blankData[i] = null;
    }
    return blanks;
  }

  List<DraggableOption> _buildOptions() {
    List<String> words = widget.subtasks
        .elementAt(_currentSubtask)
        .sentence
        .toString()
        .split(" ");
    words.shuffle();

    List<DraggableOption> optionWidgets = [];
    for (int i = 0; i < words.length; i++) {
      optionWidgets.add(
        DraggableOption(
          text: words.elementAt(i),
          optionSerial: i,
          renderKey: GlobalKey(),
        ),
      );
    }
    return optionWidgets;
  }
}
