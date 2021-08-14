import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class IncorrectDialog extends StatefulWidget {
  final Function onContinue;
  final Function onExplain;

  const IncorrectDialog(
      {Key key, @required this.onContinue, @required this.onExplain})
      : super(key: key);

  @override
  _IncorrectDialogState createState() => _IncorrectDialogState();
}

class _IncorrectDialogState extends State<IncorrectDialog> {
  AudioPlayer audioPlayer;

  Future<void> playSound() async {
    await audioPlayer.setAsset('assets/sounds/wrong_answer.mp3');
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
        backgroundColor: Colors.red.shade200,
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
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.redAccent.shade400,
                        child: Icon(
                          Icons.close_rounded,
                          size: 24,
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
                          "Incorrect!",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.redAccent.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildExplanationButton(context),
                    SizedBox(
                      width: 10,
                    ),
                    _buildContinueButton(context),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ElevatedButton _buildExplanationButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 10),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.redAccent.shade400),
        elevation: MaterialStateProperty.all(5.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        shadowColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorDark),
      ),
      child: Text(
        'Show Explanation',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: widget.onExplain,
    );
  }

  ElevatedButton _buildContinueButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 10),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.redAccent.shade400),
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
