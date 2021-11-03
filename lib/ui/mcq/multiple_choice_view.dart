import 'package:Vasha_Shikkha/data/models/mcq.dart';
import 'package:Vasha_Shikkha/ui/mixins/exercise_mixin.dart';
import 'package:Vasha_Shikkha/ui/mixins/choice_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';

class MultipleChoiceView extends StatefulWidget {
  static const String route = '/multiple-choice';
  final List<MCQ> subtasks;

  const MultipleChoiceView({Key key, @required this.subtasks})
      : super(key: key);

  @override
  _MultipleChoiceViewState createState() => _MultipleChoiceViewState();
}

class _MultipleChoiceViewState extends State<MultipleChoiceView>
    with ExerciseMixin, ChoiceMixin {
  int _currentSubtask;
  // int _selectedOption, _correctOption;
  // bool _showCorrect;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    initOptions();
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Multiple Choice Question",
      subtaskCount: widget.subtasks.length,
      instruction: widget.subtasks.elementAt(_currentSubtask).instruction,
      onShowAnswer: onShowAnswer,
      onCheck: () {
        bool res = onCheck(widget.subtasks.elementAt(_currentSubtask).answer,
            widget.subtasks.elementAt(_currentSubtask).options);
        if (res) correctAnswerCount++;
        return res;
      },
      onReset: onReset,
      onContinue: () {
        if (_currentSubtask + 1 < widget.subtasks.length) {
          setState(() {
            _currentSubtask++;
            onContinue();
          });
        } else {
          onComplete(context, widget.subtasks.length);
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
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Choose the correct option",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Text(_buildQuestion()),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              _buildOptions(),
            ],
          ),
        ),
      ),
    );
  }

  _buildQuestion() {
    String question = widget.subtasks.elementAt(_currentSubtask).question;
    return question.replaceAll(RegExp('#'), '_____\t');
  }

  ListView _buildOptions() {
    List<String> options = widget.subtasks.elementAt(_currentSubtask).options;
    correctOption =
        options.indexOf(widget.subtasks.elementAt(_currentSubtask).answer);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      clipBehavior: Clip.antiAlias,
      itemBuilder: (context, index) {
        return Card(
          elevation: index == selectedOption ? 20 : 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: getOptionColor(index, context),
          child: ListTile(
            selected: index == selectedOption,
            title: Text(
              options[index],
              style: TextStyle(
                  color: index == selectedOption ? Colors.white : Colors.black),
            ),
            onTap: () {
              if (index == selectedOption) {
                setState(() {
                  selectedOption = -1;
                });
              } else {
                setState(() {
                  selectedOption = index;
                });
              }
            },
          ),
        );
      },
    );
  }
}
