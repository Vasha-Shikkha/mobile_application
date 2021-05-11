import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/progress_slider.dart';
import 'package:Vasha_Shikkha/ui/topic/tutorial_screen.dart';

class SubtopicCard extends StatelessWidget {
  final int level;
  final int topicId;
  final String topicName;
  final String imageAssetName;
  final double progress;

  const SubtopicCard({
    Key key,
    @required this.topicName,
    @required this.imageAssetName,
    this.progress = 0,
    @required this.level,
    @required this.topicId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TutorialScreen(
              subtopicName: topicName,
              level: level,
              topicId: topicId,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageAssetName,
                  fit: BoxFit.fill,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            Text(
              topicName,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
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
