import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/topic/exercise_list_screen.dart';

class TutorialScreen extends StatelessWidget {
  final String subtopicName;

  const TutorialScreen({Key key, @required this.subtopicName})
      : super(key: key);

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
                subtopicName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse convallis lobortis purus. In ac porta libero.\n\nPraesent tortor ipsum, tincidunt ut luctus vel, vehicula sed nunc. Pellentesque ullamcorper facilisis iaculis. Sed vitae faucibus enim, ut pellentesque leo.\n\nPraesent aliquam in odio in efficitur. Suspendisse potenti. In pellentesque, ex in pretium posuere, augue nibh porttitor ex, at ultrices leo ligula molestie sapien. Pellentesque semper sollicitudin risus, non eleifend tellus convallis nec.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColorDark),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ExerciseListScreen(subtopicName: subtopicName),
                    ),
                  );
                },
                child: Text(
                  'Try Exercises',
                  style: TextStyle(
                    fontSize: 20,
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
