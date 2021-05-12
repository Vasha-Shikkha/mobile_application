import 'package:flutter/material.dart';

class TaskComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Text('You have successfully completed this task!'),
      ),
    );
  }
}
