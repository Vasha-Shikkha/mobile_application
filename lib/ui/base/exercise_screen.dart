import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/correct_dialog.dart';
import 'package:Vasha_Shikkha/ui/base/incorrect_dialog.dart';

class ExerciseScreen extends StatefulWidget {
  final String exerciseName;
  final int subtaskCount;
  final int initialSubtask;
  final Widget exercise;
  final Function onCheck;
  final Function onReset;
  final Function onContinue;
  final Function onExplain;

  ExerciseScreen({
    Key key,
    @required this.exerciseName,
    @required this.exercise,
    @required this.onCheck,
    @required this.onReset,
    @required this.onContinue,
    @required this.subtaskCount,
    @required this.initialSubtask,
    @required this.onExplain,
  }) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _checkCalled = false;
  int _currentSubtask;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _currentSubtask = widget.initialSubtask;
    _tabController = TabController(length: widget.subtaskCount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
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
        title: Text(
          widget.exerciseName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurple,
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
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, top: 8),
            child: _buildTaskSteps(),
          ),
          widget.exercise,
        ],
      ),
      bottomSheet: _checkCalled
          ? _buildCheckResult()
          : _buildPersistentBottomSheet(context),
    );
  }

  Widget _buildTaskSteps() {
    return TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.zero,
      controller: _tabController,
      indicatorColor: Colors.transparent,
      onTap: (index) {},
      tabs: List.generate(
        widget.subtaskCount,
        (index) => Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index <= _currentSubtask ? Colors.purple : Colors.grey,
          ),
          child: Center(
            child: index < _currentSubtask
                ? Icon(
                    Icons.check,
                    size: 16,
                  )
                : Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ).toList(),
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
              child: _buildResetButton(context),
            ),
          ),
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
            if (_currentSubtask + 1 < widget.subtaskCount) {
              _currentSubtask++;
              _tabController.animateTo(_currentSubtask);
            }
          });
        },
      );
    } else {
      return IncorrectDialog(
        onExplain: widget.onExplain,
        onContinue: () {
          widget.onContinue();
          setState(() {
            _checkCalled = false;
            if (_currentSubtask + 1 < widget.subtaskCount) {
              _currentSubtask++;
              _tabController.animateTo(_currentSubtask);
            }
          });
        },
      );
    }
  }

  OutlinedButton _buildResetButton(BuildContext context) {
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
      child: Text('Reset'),
      onPressed: () {
        widget.onReset();
      },
    );
  }

  OutlinedButton _buildSkipButton(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorLight),
        foregroundColor: MaterialStateProperty.all(Colors.white),
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
        widget.onContinue();
        setState(() {
          _checkCalled = false;
          if (_currentSubtask + 1 < widget.subtaskCount) {
            _currentSubtask++;
            _tabController.animateTo(_currentSubtask);
          }
        });
      },
    );
  }
}
