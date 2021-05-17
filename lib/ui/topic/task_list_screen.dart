import 'package:Vasha_Shikkha/data/controllers/fb.dart';
import 'package:Vasha_Shikkha/data/controllers/js.dart';
import 'package:Vasha_Shikkha/data/db/token.dart';
import 'package:Vasha_Shikkha/data/models/fb.dart';
import 'package:Vasha_Shikkha/data/models/js.dart';
import 'package:Vasha_Shikkha/ui/fill_in_the_blanks/fill_in_the_blanks_view.dart';
import 'package:Vasha_Shikkha/ui/jumbled_sentence/jumbled_sentence_view.dart';
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

  // List<Exercise> exercises = [
  //   Exercise(
  //     name: 'Fill In The Blanks',
  //     imageAsset: 'assets/img/places.png',
  //     route: '/fill-in-the-blanks',
  //     progress: 44,
  //   ),
  //   Exercise(
  //     name: 'Multiple Choice Question',
  //     imageAsset: 'assets/img/birds.png',
  //     route: '/multiple-choice',
  //     progress: 12,
  //   ),
  //   Exercise(
  //     name: 'Finding Error',
  //     imageAsset: 'assets/img/places.png',
  //     route: '/find-error',
  //     progress: 81,
  //   ),
  //   Exercise(
  //     name: 'Jumbled Sentence',
  //     imageAsset: 'assets/img/food.png',
  //     route: '/jumbled-sentence',
  //   ),
  // ];

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
      List<FB> fbList = await FBController()
          .getFBList(token, widget.topicId, widget.level, 20, 0);
      if (fbList.length > 0) {
        tasks.add({
          'name': 'Fill In The Blanks',
          'subtasks': fbList,
          'route': FillInTheBlanksView.route,
        });
      }
      List<JS> jsList = await JSController()
          .getJSList(token, widget.topicId, widget.level, 20, 0);
      if (jsList.length > 0) {
        tasks.add({
          'name': 'Jumbled Sentence',
          'subtasks': jsList,
          'route': JumbledSentenceView.route,
        });
      }
    } catch (e) {
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
                          return TaskCard(
                            exerciseName: task['name'],
                            route: task['route'],
                            subtasks: task['subtasks'],
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

class Exercise {
  final String name;
  final String imageAsset;
  final String route;
  final double progress;

  Exercise({
    @required this.name,
    @required this.imageAsset,
    @required this.route,
    this.progress = 0,
  });
}