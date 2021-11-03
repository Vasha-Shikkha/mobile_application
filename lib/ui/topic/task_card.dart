import 'package:Vasha_Shikkha/data/models/sm.dart';
import 'package:Vasha_Shikkha/data/models/task.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/fill_in_the_blanks_view.dart';
import 'package:Vasha_Shikkha/ui/find_error/find_error_view.dart';
import 'package:Vasha_Shikkha/ui/jumbled_sentence/jumbled_sentence_view.dart';
import 'package:Vasha_Shikkha/ui/mcq/multiple_choice_view.dart';
import 'package:Vasha_Shikkha/ui/picture_to_word/picture_to_word_view.dart';
import 'package:Vasha_Shikkha/ui/topic/notes_screen.dart';
import 'package:Vasha_Shikkha/ui/word_matching/word_matching_view.dart';
import 'package:Vasha_Shikkha/ui/word_to_picture/word_to_picture_view.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String subtopicName;
  final String exerciseName;
  final int serial;
  final String route;
  final List<SubTask> subtasks;
  final SMList smList;

  const TaskCard({
    Key key,
    @required this.subtopicName,
    @required this.exerciseName,
    @required this.route,
    @required this.serial,
    @required this.subtasks,
    this.smList,
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
      case PictureToWordView.route:
        return PictureToWordView(
          subtasks: subtasks,
        );
      case WordToPictureView.route:
        return WordToPictureView(
          subtasks: subtasks,
        );
      case WordMatchingView.route:
        return WordMatchingView(
          subtasks: smList,
        );
      default:
        return Container();
    }
  }

  String _getNotes() {
    if (route.compareTo(WordMatchingView.route) == 0) {
      return smList.smList.elementAt(0).instruction;
    }
    return subtasks.elementAt(0).instruction;
  }

  @override
  Widget build(BuildContext context) {
    String notes = _getNotes();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => _getTaskViewWidget()),
        );
      },
      child: Card(
        color: Theme.of(context).disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
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
                    route == WordMatchingView.route
                        ? '1 question'
                        : '${subtasks.length} questions',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      (notes == null || notes.isEmpty)
                          ? Container()
                          : TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NotesScreen(
                                      subtopicName: subtopicName,
                                      exercise: _getTaskViewWidget(),
                                      notes: notes,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.note_alt),
                              label: Text("Notes"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                foregroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColorLight),
                                elevation: MaterialStateProperty.all(8.0),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                      (notes == null || notes.isEmpty)
                          ? Container()
                          : SizedBox(
                              width: 10,
                            ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => _getTaskViewWidget()),
                          );
                        },
                        icon: Icon(Icons.quiz_outlined),
                        label: Text("Exercise"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColorLight),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
