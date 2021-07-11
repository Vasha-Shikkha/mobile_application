import 'package:Vasha_Shikkha/data/models/mcq.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class MultipleChoiceView extends StatefulWidget {
  static const String route = '/multiple-choice';
  final List<MCQ> subtasks;

  const MultipleChoiceView({Key key, @required this.subtasks})
      : super(key: key);

  @override
  _MultipleChoiceViewState createState() => _MultipleChoiceViewState();
}

class _MultipleChoiceViewState extends State<MultipleChoiceView>
    with ExerciseMixin {
  int _currentSubtask;
  int _selectedOption;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    _selectedOption = -1;
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Multiple Choice Question",
      subtaskCount: widget.subtasks.length,
      initialSubtask: 0, // TODO: should be last attempted
      onCheck: () {
        if (_selectedOption == -1) return false;
        String answer = widget.subtasks.elementAt(_currentSubtask).answer;
        String selectedAnswer =
            widget.subtasks.elementAt(_currentSubtask).options[_selectedOption];
        return selectedAnswer.toLowerCase().compareTo(answer.toLowerCase()) ==
            0;
      },
      onReset: () {
        setState(() {
          _selectedOption = -1;
        });
      },
      onContinue: () {
        if (_currentSubtask + 1 < widget.subtasks.length) {
          setState(() {
            _currentSubtask++;
            _selectedOption = -1;
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
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Choose the correct option",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Text(widget.subtasks.elementAt(_currentSubtask).question),
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

  ListView _buildOptions() {
    List<String> options = widget.subtasks.elementAt(_currentSubtask).options;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      clipBehavior: Clip.antiAlias,
      itemBuilder: (context, index) {
        return Card(
          elevation: index == _selectedOption ? 20 : 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: index == _selectedOption
              ? Theme.of(context).accentColor
              : Colors.white,
          child: ListTile(
            selected: index == _selectedOption,
            title: Text(
              options[index],
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              if (index == _selectedOption) {
                setState(() {
                  _selectedOption = -1;
                });
              } else {
                setState(() {
                  _selectedOption = index;
                });
              }
            },
          ),
        );
      },
    );
  }
}
