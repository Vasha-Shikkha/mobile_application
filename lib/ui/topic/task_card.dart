import 'package:Vasha_Shikkha/data/models/task.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/fill_in_the_blanks_view.dart';
import 'package:Vasha_Shikkha/ui/find_error/find_error_view.dart';
import 'package:Vasha_Shikkha/ui/jumbled_sentence/jumbled_sentence_view.dart';
import 'package:Vasha_Shikkha/ui/mcq/multiple_choice_view.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String exerciseName;
  final int serial;
  final String route;
  final List<SubTask> subtasks;

  const TaskCard({
    Key key,
    @required this.exerciseName,
    @required this.route,
    @required this.serial,
    @required this.subtasks,
  }) : super(key: key);

  Widget _getTaskViewWidget() {
    switch (route) {
      case FillInTheBlanksView.route:
        return FillInTheBlanksView(
          subtasks: subtasks,
        );
        break;
      case JumbledSentenceView.route:
        return JumbledSentenceView(
          subtasks: subtasks,
        );
        break;
      case MultipleChoiceView.route:
        return MultipleChoiceView(
          subtasks: subtasks,
        );
        break;
      case FindErrorView.route:
        return FindErrorView(
          subtasks: subtasks,
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => _getTaskViewWidget()),
        );
      },
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  child: Text(
                    serial.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exerciseName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${subtasks.length} questions',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
