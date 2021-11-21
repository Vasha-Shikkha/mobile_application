import 'dart:io';
import 'package:Vasha_Shikkha/data/models/pw.dart';
import 'package:Vasha_Shikkha/ui/mixins/exercise_mixin.dart';
import 'package:Vasha_Shikkha/ui/mixins/choice_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';

class PictureToWordView extends StatefulWidget {
  static const String route = '/picture-to-word';

  final List<PW> subtasks;

  const PictureToWordView({Key key, @required this.subtasks}) : super(key: key);

  @override
  _PictureToWordViewState createState() => _PictureToWordViewState();
}

class _PictureToWordViewState extends State<PictureToWordView>
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
      exerciseName: "Picture To Word",
      subtaskCount: widget.subtasks.length,
      instruction:
          widget.subtasks.elementAt(_currentSubtask).exerciseInstructions,
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
              Text(widget.subtasks.elementAt(_currentSubtask).question),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Image.file(
                File(
                  widget.subtasks
                      .elementAt(_currentSubtask)
                      .image
                      .toString()
                      .substring(1),
                ),
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
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
    correctOption =
        options.indexOf(widget.subtasks.elementAt(_currentSubtask).answer);

    List<int> indices = [];
    for (int i = 0; i < options.length; i++) {
      indices.add(i);
    }
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 3,
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      options[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index == selectedOption
                            ? Colors.white
                            : Colors.black,
                      ),
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
