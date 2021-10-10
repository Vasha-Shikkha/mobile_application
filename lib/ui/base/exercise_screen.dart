import 'package:Vasha_Shikkha/ui/base/dictionary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/correct_dialog.dart';
import 'package:Vasha_Shikkha/ui/base/incorrect_dialog.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ExerciseScreen extends StatefulWidget {
  final String exerciseName;
  final int subtaskCount;
  final String instruction;
  final Widget exercise;
  final Function onShowAnswer;
  final Function onCheck;
  final Function onReset;
  final Function onContinue;
  final Function onExplain;

  ExerciseScreen({
    Key key,
    @required this.exerciseName,
    @required this.exercise,
    this.instruction,
    @required this.onShowAnswer,
    @required this.onCheck,
    @required this.onReset,
    @required this.onContinue,
    @required this.subtaskCount,
    @required this.onExplain,
  }) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _checkCalled = false,
      _showInstruction = false,
      _instructionAvailable = false;
  int _currentSubtask;
  List<bool> _status = [];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _currentSubtask = 0;
    if (widget.instruction != null && widget.instruction.isNotEmpty) {
      _instructionAvailable = true;
    }
    if (_instructionAvailable) {
      _showInstruction = true;
      _currentSubtask = -1;
      _tabController =
          TabController(length: widget.subtaskCount + 1, vsync: this);
    } else {
      _tabController = TabController(length: widget.subtaskCount, vsync: this);
    }
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
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
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
              showDialog(
                context: context,
                builder: (context) => DictionaryDialog(),
              );
            },
          ),
          // IconButton(
          //   padding: EdgeInsets.zero,
          //   splashRadius: 18,
          //   icon: Icon(
          //     Icons.description_rounded,
          //     color: Theme.of(context).primaryColorDark,
          //   ),
          //   onPressed: () {
          //     // TODO: show tutorial
          //     showDialog(
          //       context: context,
          //       builder: (context) => Card(
          //         margin: EdgeInsets.symmetric(
          //           horizontal: 16,
          //           vertical: MediaQuery.of(context).size.height / 3,
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //           child: Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     'Tutorial',
          //                     style: Theme.of(context).textTheme.headline6,
          //                   ),
          //                   Align(
          //                     alignment: Alignment.centerRight,
          //                     child: IconButton(
          //                       highlightColor: Colors.transparent,
          //                       splashColor: Colors.transparent,
          //                       icon: Icon(
          //                         Icons.cancel,
          //                         color: Theme.of(context).accentColor,
          //                       ),
          //                       onPressed: () {
          //                         Navigator.of(context).pop();
          //                       },
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               Text(
          //                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse convallis lobortis purus. In ac porta libero.\n\nPraesent tortor ipsum, tincidunt ut luctus vel, vehicula sed nunc. Pellentesque ullamcorper facilisis iaculis. Sed vitae faucibus enim, ut pellentesque leo.\n\nPraesent aliquam in odio in efficitur. Suspendisse potenti. In pellentesque, ex in pretium posuere, augue nibh porttitor ex, at ultrices leo ligula molestie sapien. Pellentesque semper sollicitudin risus, non eleifend tellus convallis nec.',
          //                 maxLines: 8,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: _buildTaskSteps(),
          ),
          _showInstruction
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: HtmlWidget(widget.instruction),
                )
              : widget.exercise,
        ],
      ),
      bottomSheet: _showInstruction
          ? Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentSubtask == -1) {
                    _currentSubtask = 0;
                  }
                  setState(() {
                    _showInstruction = false;
                  });
                  _tabController.animateTo(_currentSubtask + 1);
                },
                child: Text('Continue'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple.shade100),
                  foregroundColor:
                      MaterialStateProperty.all(Colors.deepPurple.shade900),
                  elevation: MaterialStateProperty.all(5.0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  shadowColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorDark),
                ),
              ),
            )
          : (_checkCalled
              ? _buildCheckResult()
              : _buildPersistentBottomSheet(context)),
    );
  }

  Widget _buildTaskSteps() {
    return TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.zero,
      controller: _tabController,
      indicatorColor: Colors.transparent,
      onTap: (index) {
        if (index == 0 && _instructionAvailable) {
          _tabController.animateTo(0);
          setState(() {
            _showInstruction = true;
          });
        }
      },
      tabs: List.generate(
        _instructionAvailable ? (widget.subtaskCount + 1) : widget.subtaskCount,
        (index) => Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getStepColor(index),
          ),
          child: Center(
            child: _getStepContent(index),
          ),
        ),
      ).toList(),
    );
  }

  StatelessWidget _getStepContent(int index) {
    int i;
    if (_instructionAvailable) {
      if (index == 0) {
        return Icon(
          Icons.lightbulb_outline,
          size: 16,
          color: Colors.white,
        );
      }
      i = index - 1;
    } else {
      i = index;
    }

    return (i < _currentSubtask)
        ? Icon(
            (_status[i] ? Icons.check : Icons.close),
            size: 16,
            color: Colors.white,
          )
        : Text(
            '${i + 1}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          );
  }

  MaterialColor _getStepColor(int index) {
    if (_instructionAvailable) {
      if (index == 0)
        return Colors.purple;
      else
        return (index - 1 <= _currentSubtask) ? Colors.purple : Colors.grey;
    } else {
      return (index <= _currentSubtask) ? Colors.purple : Colors.grey;
    }
  }

  Widget _buildPersistentBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).primaryColorLight),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
        widget.onShowAnswer();
        setState(() {
          _checkCalled = true;
        });
      },
    );
  }

  Widget _buildCheckResult() {
    if (widget.onCheck()) {
      _status.add(true);
      return CorrectDialog(
        onContinue: () {
          widget.onContinue();
          setState(() {
            _checkCalled = false;
            if (_currentSubtask + 1 < widget.subtaskCount) {
              _currentSubtask++;
              _tabController.animateTo(_instructionAvailable
                  ? (_currentSubtask + 1)
                  : _currentSubtask);
            }
          });
        },
      );
    } else {
      _status.add(false);
      return IncorrectDialog(
        onExplain: widget.onExplain,
        onContinue: () {
          widget.onContinue();
          setState(() {
            _checkCalled = false;
            if (_currentSubtask + 1 < widget.subtaskCount) {
              _currentSubtask++;
              _tabController.animateTo(_instructionAvailable
                  ? (_currentSubtask + 1)
                  : _currentSubtask);
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
        _status.add(false);
        widget.onContinue();
        setState(() {
          _checkCalled = false;
          if (_currentSubtask + 1 < widget.subtaskCount) {
            _currentSubtask++;
            _tabController.animateTo(_instructionAvailable
                ? (_currentSubtask + 1)
                : _currentSubtask);
          }
        });
      },
    );
  }
}
