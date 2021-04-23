import 'package:flutter/material.dart';
import 'package:vasha_shikkha/ui/topic/exercise_card.dart';

class ExerciseListScreen extends StatefulWidget {
  final String subtopicName;

  const ExerciseListScreen({Key key, @required this.subtopicName})
      : super(key: key);

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  List<Exercise> exercises = [
    Exercise(
      name: 'Fill In The Blanks',
      imageAsset: 'assets/img/places.png',
      route: '/fill-in-the-blanks',
      progress: 44,
    ),
    Exercise(
      name: 'Multiple Choice Question',
      imageAsset: 'assets/img/birds.png',
      route: '/multiple-choice',
      progress: 12,
    ),
    Exercise(
      name: 'Error Correction',
      imageAsset: 'assets/img/places.png',
      route: '/error-correction',
      progress: 81,
    ),
    Exercise(
      name: 'Jumbled Sentence',
      imageAsset: 'assets/img/food.png',
      route: '/fb',
    ),
  ];

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
              ...exercises
                  .map((e) => ExerciseCard(
                        exerciseName: e.name,
                        imageAssetName: e.imageAsset,
                        route: e.route,
                        progress: e.progress,
                      ))
                  .toList(),
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
