import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CorrectDialog extends StatefulWidget {
  final Function onContinue;

  const CorrectDialog({Key key, @required this.onContinue}) : super(key: key);

  @override
  _CorrectDialogState createState() => _CorrectDialogState();
}

class _CorrectDialogState extends State<CorrectDialog> {
  AudioPlayer audioPlayer;

  Future<void> playSound() async {
    await audioPlayer.setAsset('assets/sounds/right_answer.mp3');
    audioPlayer.setSpeed(1.2);
    audioPlayer.play();
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    playSound();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: BottomSheet(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          Icons.check_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Correct!",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildContinueButton(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ElevatedButton _buildContinueButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 30),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
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
      child: Text('Continue'),
      onPressed: widget.onContinue,
    );
  }
}
