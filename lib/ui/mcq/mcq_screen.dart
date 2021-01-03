import 'dart:convert';

import 'package:Vasha_Shikkha/style/colors.dart';
import 'package:Vasha_Shikkha/ui/mcq/mcq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class McqScreen extends StatefulWidget {
  @override
  _McqScreenState createState() => _McqScreenState();
}

class _McqScreenState extends State<McqScreen> with TickerProviderStateMixin {
  bool _isLoading = false;
  int _score = 0;
  int _percentage = 0;
  int _taskno;
  Stopwatch _stopwatch;

  List<MCQ> _mcqList = List();
  List<String> _options = List();
  String _question;
  int _selectedOption = -1;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController __controller;

  @override
  void initState() {
    super.initState();
    __controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 200),
    );
    _stopwatch = Stopwatch();
    _taskno = 0;
    _playAnimation();

    _fetchData();
  }

  @override
  void dispose() {
    __controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedBuilder(
                          animation: __controller,
                          builder: (BuildContext context, Widget child) {
                            return LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 80,
                              lineHeight: 14.0,
                              percent: _percentage / 100,
                              backgroundColor: Colors.amber,
                              progressColor: Colors.redAccent,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedBuilder(
                          animation: __controller,
                          builder: (BuildContext context, Widget child) {
                            return Text(
                              "Time: " + timerString,
                            );
                          },
                        ),
                        Text("Score: " + _score.toString()),
                      ],
                    ),
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 60),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 43),
                    child: Text(
                      'Choose the correct option',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Text(
                      _question,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                      ),
                      child: _buildMcqOptions(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        child: const Text(
                          'Check',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _checkAnswer();
                            _generateNextTask();
                          });
                        },
                        padding: EdgeInsets.only(
                            top: 10, left: 60.0, right: 60.0, bottom: 10),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(30),
            ),
    );
  }

  Widget _buildMcqOptions() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _options.length,
      padding: EdgeInsets.only(bottom: 10),
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      clipBehavior: Clip.antiAlias,
      itemBuilder: (context, index) {
        return Card(
          elevation: index == _selectedOption ? 20 : 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: index == _selectedOption
              ? CustomColors.loginGradientStart
              : Colors.white,
          child: ListTile(
            selected: index == _selectedOption,
            title: Text(
              _options[index],
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              if (index == _selectedOption) {
                setState(() {
                  _selectedOption = -1;
                });
              } else {
                setState(() {
                  _selectedOption = index;
                });
              }
            },
          ),
        );
      },
    );
  }

  String get timerString {
    Duration duration = _stopwatch.elapsed;

    return '${duration.inMinutes % 60}:${(duration.inSeconds - (duration.inMinutes * 60)).toString().padLeft(2, '0')}';
  }

  Future<Null> _playAnimation() async {
    try {
      // await __controller.repeat().orCancel;
      await __controller.reverse(
          from: __controller.value == 0.0 ? 1.0 : __controller.value);
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    _mcqList = (json.decode(await _loadFromAsset()) as List)
        .map((data) => MCQ.fromJson(data))
        .toList();

    setState(() {
      _isLoading = false;
      _stopwatch.start();
      _generateNextTask();
    });
  }

  void _generateNextTask() {
    _taskno = (_taskno + 1) % 10;
    _question = _mcqList[_taskno].question;
    _options = _mcqList[_taskno].options;
    _selectedOption = -1;
  }

  void _checkAnswer() async {
    if (_selectedOption == -1) {
      _showDialog("No input", "Please select answer");
      return;
    }

    if (_mcqList[_taskno].correctOption == _options[_selectedOption]) {
      _score += 10;
      _percentage += 10;

      if (_percentage >= 100) {
        _percentage = 100;
        // Exercise completed
        _stopwatch.stop();
        Duration duration = _stopwatch.elapsed;

        await _showDialog("Great Job!",
            "You have completed this exercise in ${duration.inMinutes} minutes ${duration.inSeconds - duration.inMinutes * 60} seconds.");
        Navigator.of(context).pushReplacementNamed('/mcq');
      } else {
        _showDialog("Correct answer", "Well Done!");
      }
    } else {
      _showDialog("Wrong answer", "Better luck next time!");
      _score -= 5;
      _percentage -= 5;

      _percentage < 0 ? _percentage = 0 : _percentage = _percentage;
    }
  }

  Future<void> _showDialog(String text, String msg) {
    // flutter defined function
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(text),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Next"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/json/mock_mcq.json");
  }
}
