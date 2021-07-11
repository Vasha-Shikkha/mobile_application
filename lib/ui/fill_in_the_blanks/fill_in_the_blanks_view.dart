import 'package:Vasha_Shikkha/data/models/fb.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:Vasha_Shikkha/ui/base/task_complete.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'widgets/drag_target_blank.dart';
import 'widgets/draggable_option.dart';
import 'package:flutter/material.dart';

class FillInTheBlanksView extends StatefulWidget {
  static const String route = '/fill-in-the-blanks';
  final List<FB> subtasks;

  const FillInTheBlanksView({Key key, @required this.subtasks})
      : super(key: key);

  @override
  _FillInTheBlanksViewState createState() => _FillInTheBlanksViewState();
}

class _FillInTheBlanksViewState extends State<FillInTheBlanksView>
    with ExerciseMixin {
  int _currentSubtask;
  ScrollController _scrollController;
  Map<int, String> _blankData;
  List<Widget> _sentenceWidgets;
  List<DraggableOption> _optionWidgets;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _scrollController = ScrollController();
    _blankData = {};
    _optionWidgets = [];
    _buildOptions();
    _sentenceWidgets = [];
    _buildSentenceWidgets();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  void _buildSentenceWidgets() {
    // check for dialogue
    String sentence = widget.subtasks.elementAt(_currentSubtask).paragraph;

    int blankCount = 0;
    _sentenceWidgets.clear();
    List<String> articles = ["a", "an", "the"];
    List<String> punctuation = [",", ".", ";", "?", "!", ":"];

    sentence = sentence.replaceAll(RegExp(r':'), ' : ');

    int startIndex = 0;
    int index = sentence.indexOf("#");
    String formattedSentence = "";
    while (index >= 0) {
      formattedSentence += sentence.substring(startIndex, index);
      formattedSentence += " # ";
      startIndex = index + 1;
      index = sentence.indexOf("#", startIndex);
    }
    formattedSentence += sentence.substring(startIndex);

    List<String> words = formattedSentence.split(" ");

    words.forEach((word) {
      if (word.contains("#")) {
        final blank = DragTargetBlank(
          serial: blankCount,
          updateBlankData: _updateBlankData,
        );
        _sentenceWidgets.add(blank);
        _blankData[blankCount] = null;
        blankCount++;
      } else if (word.contains("\n")) {
        int index = word.indexOf('\n');
        _sentenceWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text('${word.substring(0, index)}'),
        ));
        _sentenceWidgets.add(
          SizedBox(
            width: 1000,
          ),
        );
        _sentenceWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text('${word.substring(index + 1)}'),
        ));
      } else if (articles.contains(word.toLowerCase()) ||
          punctuation.contains(word)) {
        _sentenceWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '$word ',
          ),
        ));
      } else {
        _sentenceWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '$word ',
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Fill in the blanks",
      subtaskCount: widget.subtasks.length,
      initialSubtask: 0, // TODO: should be last attempted
      onReset: () {
        setState(() {
          _blankData = {};
          _buildOptions();
          _buildSentenceWidgets();
        });
      },
      onCheck: () {
        bool correct = true;
        List<String> answers =
            widget.subtasks.elementAt(_currentSubtask).answers;
        for (int i = 0; i < answers.length; i++) {
          if (answers
                  .elementAt(i)
                  .toLowerCase()
                  .compareTo(_blankData[i]?.toLowerCase() ?? '') !=
              0) {
            correct = false;
          }
        }
        print(_blankData);
        return correct;
      },
      onContinue: () {
        if (_currentSubtask + 1 < widget.subtasks.length) {
          setState(() {
            _currentSubtask++;
            _blankData = {};
            _buildOptions();
            _buildSentenceWidgets();
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
        widget.subtasks.elementAt(_currentSubtask).explanation.join('\n'),
      ),
      exercise: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, bottom: 20),
              //   child: Text(
              //     "Fill in the blanks using the given words",
              //     style: Theme.of(context).textTheme.bodyText1,
              //   ),
              // ),
              Wrap(
                alignment: WrapAlignment.center,
                children: _optionWidgets,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: Material(
                    type: MaterialType.card,
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    child: Container(
                      color: Theme.of(context).accentColor.withOpacity(0.1),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        controller: _scrollController,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: _sentenceWidgets,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildOptions() {
    List<String> options = widget.subtasks.elementAt(_currentSubtask).options;
    options.shuffle();
    _optionWidgets.clear();
    for (int i = 0; i < options.length; i++) {
      _optionWidgets.add(
        DraggableOption(
          text: options.elementAt(i),
          optionSerial: i,
          renderKey: GlobalKey(),
        ),
      );
    }
  }
}
