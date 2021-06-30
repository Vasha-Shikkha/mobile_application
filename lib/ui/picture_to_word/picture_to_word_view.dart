import 'package:Vasha_Shikkha/data/models/mcq.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class PTW {
  int ptwId;
  String question;
  String imagePath;
  List<String> options;
  String answer;
  String explanation;

  PTW({
    @required this.ptwId,
    @required this.question,
    @required this.imagePath,
    @required this.options,
    @required this.answer,
    @required this.explanation,
  });
}

class PictureToWordView extends StatefulWidget {
  static const String route = '/picture-to-word';
  final List<PTW> subtasks = [
    PTW(
      ptwId: 1,
      question: "Select the word that best matches the picture",
      imagePath: "assets/img/doctor.png",
      options: ["nurse", "teacher", "doctor", "police", "actor"],
      answer: "doctor",
      explanation: "",
    ),
  ];
  // final List<MCQ> subtasks;

  // const PictureToWordView({Key key, @required this.subtasks}) : super(key: key);

  @override
  _PictureToWordViewState createState() => _PictureToWordViewState();
}

class _PictureToWordViewState extends State<PictureToWordView>
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
      exerciseName: "Picture To Word",
      subtaskCount: widget.subtasks.length,
      initialSubtask: 0, // TODO: should be last attempted
      onCheck: () {
        if (_selectedOption == -1) return false;
        String answer = widget.subtasks.elementAt(_currentSubtask).answer;
        String selectedAnswer =
            widget.subtasks.elementAt(_currentSubtask).options[_selectedOption];
        return selectedAnswer.compareTo(answer) == 0;
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
              Image.asset(
                widget.subtasks.elementAt(_currentSubtask).imagePath,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: _buildOptions(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView _buildOptions() {
    List<String> options = widget.subtasks.elementAt(_currentSubtask).options;
    List<int> indices = [];
    for (int i = 0; i < options.length; i++) {
      indices.add(i);
    }
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 4,
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
                    ? Theme.of(context).accentColor
                    : Colors.white,
                child: Center(
                  child: Text(
                    options[index],
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}