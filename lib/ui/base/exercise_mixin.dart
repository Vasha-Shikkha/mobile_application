import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

mixin ExerciseMixin {
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
}
