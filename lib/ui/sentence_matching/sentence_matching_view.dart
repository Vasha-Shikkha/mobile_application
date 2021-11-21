import 'package:Vasha_Shikkha/data/models/sm.dart';
import 'package:Vasha_Shikkha/ui/mixins/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:Vasha_Shikkha/ui/drag/drag_target_blank.dart';
import 'package:Vasha_Shikkha/ui/drag/draggable_option.dart';

class SentenceMatchingView extends StatefulWidget {
  static const String route = '/sentence-matching';

  final SMList subtasks;

  const SentenceMatchingView({Key key, @required this.subtasks})
      : super(key: key);

  @override
  _SentenceMatchingViewState createState() => _SentenceMatchingViewState();
}

class _SentenceMatchingViewState extends State<SentenceMatchingView>
    with ExerciseMixin {
  int _currentSubtask;
  Map<int, String> _blankData;
  List<DragTargetBlank> _blanks;
  List<DraggableOption> _optionWidgets;
  ScrollController _optionScrollController, _blankScrollController;

  List<List<SM>> _lists;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _optionScrollController = ScrollController();
    _blankScrollController = ScrollController();
    _divideList();
    _blankData = {};
    _optionWidgets = [];
    _buildOptions();
    _buildBlanks();
  }

  @override
  void dispose() {
    _optionScrollController.dispose();
    _blankScrollController.dispose();
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

  String _buildExplanation() {
    String explanation = "";
    List<String> parts = widget.subtasks
        .getParts(_lists[_currentSubtask])['Explanations']
        .toList();
    for (int i = 0; i < parts.length; i++) {
      explanation += (i + 1).toString() + ") ";
      explanation += parts[i] + "\n";
    }
    return explanation;
  }

  _divideList() {
    _lists = [];
    int division = (widget.subtasks.smList.length / 3).ceil();

    if (division == 1) {
      _lists.add(widget.subtasks.smList);
    } else {
      for (int i = 0; i < division - 1; i++) {
        _lists.add(widget.subtasks.smList.sublist(3 * i, 3 * (i + 1)));
      }
      _lists.add(widget.subtasks.smList.sublist(3 * (division - 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Sentence Matching",
      subtaskCount: _lists.length,
      instruction: widget.subtasks.smList.first.exerciseInstructions,
      onShowAnswer: () {},
      onCheck: () {
        bool correct = true;
        List<String> answers = widget.subtasks
            .getParts(_lists[_currentSubtask])['PartTwo']
            .toList();
        for (int i = 0; i < answers.length; i++) {
          if (answers
                  .elementAt(i)
                  .toLowerCase()
                  .compareTo(_blankData[i]?.toLowerCase() ?? '') !=
              0) {
            correct = false;
            break;
          }
        }
        if (correct) correctAnswerCount++;
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
        if (_currentSubtask + 1 < _lists.length) {
          setState(() {
            _currentSubtask++;
            _blankData = {};
            _buildBlanks();
            _buildOptions();
          });
        } else {
          onComplete(context, _lists.length);
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, bottom: 20),
              //   child: Text(
              //     "Take words from the box and match with related words",
              //     style: Theme.of(context).textTheme.bodyText1,
              //   ),
              // ),
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _blankScrollController,
                  child: Material(
                    type: MaterialType.card,
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    child: Container(
                      color: Theme.of(context).accentColor.withOpacity(0.1),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        controller: _blankScrollController,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: _lists[_currentSubtask].length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.subtasks
                                      .getParts(
                                          _lists[_currentSubtask])['PartOne']
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

  void _buildBlanks() {
    List<String> words =
        widget.subtasks.getParts(_lists[_currentSubtask])['PartTwo'].toList();
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
        widget.subtasks.getParts(_lists[_currentSubtask])['PartTwo'].toList();
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
