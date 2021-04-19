import 'package:flutter/material.dart';
import 'package:vasha_shikkha/ui/base/progress_slider.dart';

class ExerciseCard extends StatelessWidget {
  final String exerciseName;
  final String imageAssetName;
  final String route;
  final double progress;

  const ExerciseCard(
      {Key key,
      @required this.exerciseName,
      @required this.imageAssetName,
      @required this.route,
      this.progress = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
          child: Row(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exerciseName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ProgressSlider(
                    value: progress,
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
