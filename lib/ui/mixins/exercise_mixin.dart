import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

mixin ExerciseMixin {
  int correctAnswerCount = 0;

  void onExplain(BuildContext context, String explanation) {
    showAnimatedDialog(
      context: context,
      animationType: DialogTransitionType.fadeScale,
      builder: (context) => ClassicGeneralDialogWidget(
        titleText: 'Explanation',
        contentText: explanation == null || explanation.isEmpty
            ? 'No explanation available'
            : explanation,
        onNegativeClick: null,
        positiveText: 'OK',
        onPositiveClick: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void onComplete(BuildContext context, int questionCount) {
    int imageChoice = Random().nextInt(2);
    String imageName =
        imageChoice == 0 ? "correct_answer_boy.png" : "correct_answer_girl.png";

    showAnimatedDialog(
      context: context,
      animationType: DialogTransitionType.fadeScale,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 150),
        child: CustomDialogWidget(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Task Complete!",
            textAlign: TextAlign.center,
          ),
          content: Column(
            children: [
              Image.asset(
                "assets/img/exercise/$imageName",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.height / 3.5,
                height: MediaQuery.of(context).size.height / 3.5,
              ),
              Text(
                  'You got $correctAnswerCount out of $questionCount correct!'),
              SizedBox(
                height: 8,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(8.0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
