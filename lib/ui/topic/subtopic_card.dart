import 'package:flutter/material.dart';
import 'package:vasha_shikkha/ui/base/progress_slider.dart';
import 'package:vasha_shikkha/ui/topic/tutorial_screen.dart';

class SubtopicCard extends StatelessWidget {
  final String topicName;
  final String imageAssetName;
  final double progress;

  const SubtopicCard({
    Key key,
    @required this.topicName,
    @required this.imageAssetName,
    this.progress = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TutorialScreen(subtopicName: topicName),
          ),
        );
      },
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageAssetName,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
            ),
            Text(
              topicName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ProgressSlider(
                value: progress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
