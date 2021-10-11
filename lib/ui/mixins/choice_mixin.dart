import 'package:flutter/material.dart';

mixin ChoiceMixin<T extends StatefulWidget> on State<T> {
  int selectedOption, correctOption;
  bool showCorrect;

  void initOptions() {
    selectedOption = -1;
    correctOption = -1;
    showCorrect = false;
  }

  void onShowAnswer() {
    setState(() {
      showCorrect = true;
    });
  }

  bool onCheck(String answer, List<String> options) {
    if (selectedOption == -1) return false;

    return options[selectedOption]
            .toLowerCase()
            .compareTo(answer.toLowerCase()) ==
        0;
  }

  void onReset() {
    setState(() {
      selectedOption = -1;
    });
  }

  void onContinue() {
    selectedOption = -1;
    correctOption = -1;
    showCorrect = false;
  }

  Color getOptionColor(int index, BuildContext context) {
    if (showCorrect) {
      if (index == correctOption)
        return Colors.greenAccent.shade700;
      else if (index == selectedOption) {
        print("$index, $selectedOption, $correctOption");
        return Colors.redAccent;
      } else
        return Colors.white;
    }
    return index == selectedOption
        ? Theme.of(context).primaryColorLight
        : Colors.white;
  }
}
