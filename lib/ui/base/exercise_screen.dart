import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/correct_dialog.dart';
import 'package:Vasha_Shikkha/ui/base/incorrect_dialog.dart';

class ExerciseScreen extends StatefulWidget {
  final String exerciseName;
  final int subtaskCount;
  final int initialSubtask;
  final Widget exercise;
  final Function onCheck;
  final Function onContinue;

  ExerciseScreen({
    Key key,
    @required this.exerciseName,
    @required this.exercise,
    @required this.onCheck,
    @required this.onContinue,
    @required this.subtaskCount,
    @required this.initialSubtask,
  }) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _checkCalled = false;
  int _currentSubtask;

  @override
  void initState() {
    super.initState();
    _currentSubtask = widget.initialSubtask;
  }

  StepState _getStepState(int index) {
    if (index < _currentSubtask) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            widget.exerciseName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple,
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 18,
            icon: Icon(
              Icons.search_rounded,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // TODO: show dictionary search
            },
          ),
          IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 18,
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
          SizedBox(
            height: 80,
            child: Theme(
              data: ThemeData(
                primarySwatch: Colors.purple,
                canvasColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              child: Stepper(
                physics: ScrollPhysics(),
                type: StepperType.horizontal,
                currentStep: _currentSubtask,
                steps: List<Step>.generate(
                  widget.subtaskCount,
                  (index) => Step(
                    title: Container(),
                    content: Container(),
                    state: _getStepState(index),
                    isActive: index <= _currentSubtask,
                  ),
                ),
              ),
            ),
          ),
          widget.exercise,
        ],
      ),
      bottomSheet: _checkCalled
          ? _buildCheckResult()
          : _buildPersistentBottomSheet(context),
    );
  }

  Padding _buildPersistentBottomSheet(BuildContext context) {
    return Padding(
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
      onPressed: () {
        setState(() {
          _checkCalled = true;
        });
      },
    );
  }

  Widget _buildCheckResult() {
    if (widget.onCheck()) {
      return CorrectDialog(
        onContinue: () {
          widget.onContinue();
          setState(() {
            _checkCalled = false;
            if (_currentSubtask + 1 < widget.subtaskCount) _currentSubtask++;
          });
        },
      );
    } else {
      return IncorrectDialog(
        onContinue: () {
          widget.onContinue();
          setState(() {
            _checkCalled = false;
            if (_currentSubtask + 1 < widget.subtaskCount) _currentSubtask++;
          });
        },
      );
    }
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
