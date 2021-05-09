import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/exercise_screen.dart';

class MultipleChoiceView extends StatefulWidget {
  @override
  _MultipleChoiceViewState createState() => _MultipleChoiceViewState();
}

class _MultipleChoiceViewState extends State<MultipleChoiceView> {
  final String question =
      "Rehnuma has just received the result of her final examination of class 7. She has stood first in her class. She is now-";

  final List<String> _options = ["sad", "excited", "happy", "on cloud nine"];

  final String _correctOption = "on cloud nine";
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return ExerciseScreen(
      exerciseName: "Multiple Choice Question",
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
              Text(question),
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
