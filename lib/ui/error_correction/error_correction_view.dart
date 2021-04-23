import 'package:flutter/material.dart';
import 'package:vasha_shikkha/ui/base/exercise_screen.dart';

class ErrorCorrectionView extends StatefulWidget {
  @override
  _ErrorCorrectionViewState createState() => _ErrorCorrectionViewState();
}

class _ErrorCorrectionViewState extends State<ErrorCorrectionView> {
  final String _question =
      "Fahim <b>lives</b> in a village, so he <b>is</b> very curious about the daily lives of city people.";

  final List<String> _options = ["lives", "is", "No error"];

  final String _correctOption = "No error";
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Error Correction",
      exercise: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildQuestion(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              _buildOptions(),
            ],
          ),
        ),
      ),
      onCheck: _onCheck,
    );
  }

  RichText _buildQuestion() {
    RegExp regExp = RegExp("<b>");
    final matches = regExp.allMatches(_question);
    print(matches);
    List<String> sections = [];

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
              ? Theme.of(context).accentColor
              : Colors.white,
          child: ListTile(
            selected: index == _selectedOption,
            title: Text(
              _options[index],
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

  bool _onCheck() {
    if (_selectedOption == -1) return false;
    return _options[_selectedOption].compareTo(_correctOption) == 0;
  }
}
