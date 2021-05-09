import 'package:flutter/material.dart';

class ProgressSlider extends StatelessWidget {
  final double value;

  const ProgressSlider({Key key, this.value = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
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

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
