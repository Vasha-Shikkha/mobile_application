import 'package:flutter/material.dart';

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
        // TODO: navigate to exercises of this subtopic
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
            Container(
              width: double.infinity,
              height: 10,
              child: _buildSlider(context, progress),
            ),
          ],
        ),
      ),
    );
  }

  SliderTheme _buildSlider(BuildContext context, double value) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: RectangularSliderTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        trackHeight: 5,
      ),
      child: Slider.adaptive(
        value: value,
        min: 0,
        max: 100,
        activeColor: Theme.of(context).primaryColorDark.withOpacity(0.6),
        inactiveColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
        onChanged: (val) {
          // TODO: handle slider update
        },
      ),
    );
  }
}
