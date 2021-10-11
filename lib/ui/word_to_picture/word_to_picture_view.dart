import 'package:Vasha_Shikkha/data/models/wp.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:Vasha_Shikkha/ui/mixins/choice_mixin.dart';
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
    with ExerciseMixin, ChoiceMixin {
  int _currentSubtask;
  // int _selectedOption;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    initOptions();
  }

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Word To Picture",
      subtaskCount: widget.subtasks.length,
      instruction: widget.subtasks.elementAt(_currentSubtask).instruction,
      onShowAnswer: onShowAnswer,
      onCheck: () => onCheck(widget.subtasks.elementAt(_currentSubtask).answer,
          widget.subtasks.elementAt(_currentSubtask).images),
      onReset: onReset,
      onContinue: () {
        if (_currentSubtask + 1 < widget.subtasks.length) {
          setState(() {
            _currentSubtask++;
            onContinue();
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
    correctOption =
        options.indexOf(widget.subtasks.elementAt(_currentSubtask).answer);
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
              child: Card(
                elevation: index == selectedOption ? 20 : 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: getOptionColor(index, context),
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
