import 'package:Vasha_Shikkha/data/controllers/task.dart';
import 'package:Vasha_Shikkha/data/db/token.dart';
import 'package:Vasha_Shikkha/data/models/sm.dart';
import 'package:Vasha_Shikkha/data/models/task.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/fill_in_the_blanks_view.dart';
import 'package:Vasha_Shikkha/ui/find_error/find_error_view.dart';
import 'package:Vasha_Shikkha/ui/jumbled_sentence/jumbled_sentence_view.dart';
import 'package:Vasha_Shikkha/ui/mcq/multiple_choice_view.dart';
import 'package:Vasha_Shikkha/ui/picture_to_word/picture_to_word_view.dart';
import 'package:Vasha_Shikkha/ui/word_matching/word_matching_view.dart';
import 'package:Vasha_Shikkha/ui/word_to_picture/word_to_picture_view.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/topic/task_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TaskListScreen extends StatefulWidget {
  final int level;
  final int topicId;
  final String subtopicName;

  const TaskListScreen(
      {Key key,
      @required this.subtopicName,
      @required this.level,
      @required this.topicId})
      : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  bool _loading = false;

  List<Map<String, dynamic>> tasks = [];

  List<String> dummyImages = [
    'assets/img/places.png',
    'assets/img/birds.png',
    'assets/img/food.png',
  ];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    setState(() {
      _loading = true;
    });
    try {
      final t = await TokenDatabaseHelper().getToken();
      String token = t.token;

      TaskController taskController = new TaskController();

      List<TaskList> list = await taskController.getTaskList(
          token, widget.topicId, widget.level, 20, 0);

      if (list.isEmpty) return;

      if (list[0].taskName == 'Sentence Matching') {
        SMList smList = new SMList(smList: list[0].taskList);
        print('sm here');
        tasks.add({
          'name': 'Word Matching',
          'subtasks': smList,
          'route': WordMatchingView.route,
        });
      } else {
        for (TaskList tl in list) {
          final tn = tl.taskList[0].taskName;

          switch (tn) {
            case 'Picture to Word':
              print('pw here');
              tasks.add({
                'name': 'Picture To Word',
                'subtasks': tl.taskList,
                'route': PictureToWordView.route,
              });
              break;
            case 'Word to Picture':
              print('wp here');
              tasks.add({
                'name': 'Word To Picture',
                'subtasks': tl.taskList,
                'route': WordToPictureView.route,
              });
              break;
            case 'Jumbled Sentence':
              print('js here');
              tasks.add({
                'name': 'Jumbled Sentence',
                'subtasks': tl.taskList,
                'route': JumbledSentenceView.route,
              });
              break;
            case 'Fill in the Blanks':
              print('fb here');
              tasks.add({
                'name': 'Fill in the Blanks',
                'subtasks': tl.taskList,
                'route': FillInTheBlanksView.route,
              });
              break;
            case 'MCQ':
              print('mcq here');
              tasks.add({
                'name': 'Multiple Choice Question',
                'subtasks': tl.taskList,
                'route': MultipleChoiceView.route,
              });
              break;
            case 'Error in Sentence':
              print('error here');
              tasks.add({
                'name': 'Error in Sentence',
                'subtasks': tl.taskList,
                'route': FindErrorView.route,
              });
              break;
            default:
          }
        }
      }
    } catch (e) {
      print('found error');
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xFFFFB8B8),
            child: IconButton(
              padding: EdgeInsets.all(0),
              iconSize: 20,
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.subtopicName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: _loading
                    ? SpinKitThreeBounce(
                        color: Theme.of(context).accentColor,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          var sm;
                          var subtasks = task['subtasks'];
                          if (task['name'] == 'Word Matching') {
                            sm = task['subtasks'];
                            subtasks = List<SubTask>.empty();
                          }
                          return TaskCard(
                            exerciseName: task['name'],
                            route: task['route'],
                            subtasks: subtasks,
                            smList: sm,
                            serial: index + 1,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
