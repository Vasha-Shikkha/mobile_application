import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  final String exerciseName;
  final Widget exercise;
  final Function onCheck;

  const ExerciseScreen(
      {Key key, this.exerciseName, this.exercise, this.onCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: Text(
            exerciseName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.description_rounded,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // TODO: show tutorial
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSlider(context),
          SizedBox(
            height: 20.0,
          ),
          exercise,
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _buildSkipButton(context),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _buildCheckButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliderTheme _buildSlider(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: SliderComponentShape.noThumb,
        trackHeight: 10,
      ),
      child: Slider.adaptive(
        value: 0.4,
        activeColor: Theme.of(context).primaryColorDark.withOpacity(0.6),
        inactiveColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
        // divisions: 10,
        // label: '4',
        onChanged: (val) {
          // TODO: handle slider update
        },
      ),
    );
  }

  ElevatedButton _buildCheckButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorDark),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(5.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        shadowColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorDark),
      ),
      child: Text('Check'),
      onPressed: onCheck,
    );
  }

  OutlinedButton _buildSkipButton(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorDark),
        elevation: MaterialStateProperty.all(5.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Theme.of(context).primaryColorLight,
            width: 0.5,
          ),
        ),
        shadowColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorLight),
      ),
      child: Text('Skip'),
      onPressed: () {
        // TODO: handle skip
      },
    );
  }
}
