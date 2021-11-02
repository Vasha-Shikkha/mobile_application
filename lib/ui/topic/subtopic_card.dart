import 'package:Vasha_Shikkha/ui/topic/task_list_screen.dart';
import 'package:flutter/material.dart';

class SubtopicCard extends StatelessWidget {
  final int level;
  final int topicId;
  final String topicName;
  final String imageAssetName;
  // final double progress;

  const SubtopicCard({
    Key key,
    @required this.topicName,
    @required this.imageAssetName,
    // this.progress = 0,
    @required this.level,
    @required this.topicId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskListScreen(
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
          mainAxisAlignment: MainAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                topicName,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // TODO: add progress bar if tracked (in future)
            // Padding(
            //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            //   child: ProgressSlider(
            //     value: progress,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
