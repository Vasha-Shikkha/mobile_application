import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  final String topicName;

  const TopicScreen({Key key, @required this.topicName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(topicName),
      ),
    );
  }
}
