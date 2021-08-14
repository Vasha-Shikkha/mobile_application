import 'package:Vasha_Shikkha/data/models/wp.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class WTP {
  int wtpId;
  String question;
  List<String> options;
  String answer;
  String explanation;

  WTP({
    @required this.wtpId,
    @required this.question,
    @required this.options,
    @required this.answer,
    @required this.explanation,
  });
}

class WordToPictureView extends StatefulWidget {
  static const String route = '/word-to-picture';

  final List<WP> subtasks;
  // final List<WTP> subtasks = [
  //   WTP(
  //     wtpId: 1,
  //     question: "Select the picture that best matches the word Examination",
  //     options: [
  //       "assets/img/back_to_school.png",
  //       "assets/img/blank_canvas.png",
  //       "assets/img/exams.png",
  //       "assets/img/true_friends.png",
  //     ],
  //     answer: "assets/img/exams.png",
  //     explanation: "",
  //   ),
  // ];

  const WordToPictureView({Key key, @required this.subtasks}) : super(key: key);

  @override
  _WordToPictureViewState createState() => _WordToPictureViewState();
}

class _WordToPictureViewState extends State<WordToPictureView>
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
      exerciseName: "Word To Picture",
      subtaskCount: widget.subtasks.length,
      instruction: widget.subtasks.elementAt(_currentSubtask).instruction,
      onCheck: () {
        if (_selectedOption == -1) return false;
        String answer = widget.subtasks.elementAt(_currentSubtask).answer;
        String selectedAnswer =
            widget.subtasks.elementAt(_currentSubtask).images[_selectedOption];
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

  GridView _buildOptions() {
    List<String> options = widget.subtasks.elementAt(_currentSubtask).images;
    List<int> indices = [];
    for (int i = 0; i < options.length; i++) {
      indices.add(i);
    }
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: indices
          .map(
            (index) => InkWell(
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
              child: Card(
                elevation: index == _selectedOption ? 20 : 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: index == _selectedOption
                    ? Theme.of(context).primaryColorDark
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    options[index],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
