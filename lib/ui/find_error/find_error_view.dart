import 'package:Vasha_Shikkha/data/models/error.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_mixin.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class FindErrorView extends StatefulWidget {
  static const String route = '/find-error';
  final List<Error> subtasks;

  const FindErrorView({Key key, @required this.subtasks}) : super(key: key);

  @override
  _FindErrorViewState createState() => _FindErrorViewState();
}

class _FindErrorViewState extends State<FindErrorView> with ExerciseMixin {
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
      exerciseName: "Finding Error",
      subtaskCount: widget.subtasks.length,
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
                  "Find error in the given sentence",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              _buildQuestion(),
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

  RichText _buildQuestion() {
    String _question = widget.subtasks.elementAt(_currentSubtask).question;
    RegExp regExp = RegExp("<b>");
    final matches = regExp.allMatches(_question);
    print(matches);
    List<String> sections = [];
    if (matches.isEmpty) {
      sections.add(_question);
    } else {
      sections.add(_question.substring(0, matches.first.start));

      for (int i = 0; i < matches.length; i++) {
        int start = matches.elementAt(i).start + 3;
        int end = _question.indexOf("</b>", start);
        sections.add(_question.substring(start, end));
        if ((i + 1) < matches.length) {
          start = end + 4;
          end = matches.elementAt(i + 1).start;
          sections.add(_question.substring(start, end));
        } else {
          sections.add(_question.substring(end + 4));
        }
      }
    }

    List<TextSpan> spans = [];
    for (int i = 0; i < sections.length; i++) {
      bool bold = i % 2 != 0;
      print('${sections[i]} - $bold');
      spans.add(
        TextSpan(
          text: sections[i],
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.subtitle1,
        children: spans,
      ),
    );
  }

  ListView _buildOptions() {
    List<String> _options = widget.subtasks.elementAt(_currentSubtask).options;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _options.length,
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
              ? Theme.of(context).primaryColorDark
              : Colors.white,
          child: ListTile(
            selected: index == _selectedOption,
            title: Text(
              _options[index],
              style: TextStyle(
                  color:
                      index == _selectedOption ? Colors.white : Colors.black),
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
