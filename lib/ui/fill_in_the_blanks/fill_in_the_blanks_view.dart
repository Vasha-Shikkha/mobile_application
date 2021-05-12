import 'package:Vasha_Shikkha/data/models/fb.dart';
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

class _FillInTheBlanksViewState extends State<FillInTheBlanksView> {
  int _currentSubtask;
  ScrollController _scrollController;
  Map<int, String> _blankData;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _scrollController = ScrollController();
    _blankData = {};
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateBlankData(int serial, String text) {
    _blankData[serial] = text;
  }

  List<Widget> _buildSentenceWidgets(String sentence) {
    int blankCount = 0;
    List<Widget> widgets = [];
    List<String> articles = ["a", "an", "the"];
    List<String> punctuation = [",", ".", ";", "?", "!", ":"];

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
        widgets.add(blank);
        _blankData[blankCount] = null;
        blankCount++;
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
      subtaskCount: widget.subtasks.length,
      initialSubtask: 0, // TODO: should be last attempted
      onCheck: () {
        bool correct = true;
        List<String> answers =
            widget.subtasks.elementAt(_currentSubtask).answers;
        for (int i = 0; i < answers.length; i++) {
          if (answers.elementAt(i).compareTo(_blankData[i] ?? '') != 0) {
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
                children: _buildOptions(),
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
                          children: _buildSentenceWidgets(widget.subtasks
                              .elementAt(_currentSubtask)
                              .paragraph),
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

  List<DraggableOption> _buildOptions() {
    // TODO: options not reloading
    List<String> options = widget.subtasks.elementAt(_currentSubtask).options;
    options.shuffle();
    return options
        .map<DraggableOption>(
          (option) => DraggableOption(
            text: option,
            renderKey: GlobalKey(),
          ),
        )
        .toList();
  }
}
