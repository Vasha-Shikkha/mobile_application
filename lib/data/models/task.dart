import './topic.dart';

import './error.dart';
import './fb.dart';
import './js.dart';
import './jw.dart';
import './mcq.dart';
import './pw.dart';
import './sm.dart';
import './wp.dart';

class TaskList {
  List<TopicTask> _taskList;
  String _taskName;

  List<TopicTask> get taskList => this._taskList;

  set taskList(List<TopicTask> value) => this._taskList = value;

  get taskName => this._taskName;

  set taskName(String value) => this._taskName = value;

  TaskList({List<TopicTask> taskList, String taskName})
      : _taskList = taskList,
        _taskName = taskName;

  factory TaskList.fromJson(Map<String, dynamic> json) {
    print("In taskList");
    List<TopicTask> taskList = [];

    Map<String, dynamic> taskDetail = json['taskDetail'];
    String taskName = taskDetail['name'];
    List<dynamic> question = json['question'];

    for (Map<String, dynamic> subtaskDetails in question) {
      if (taskName == 'Picture to Word') {
        PW pw = new PW.fromJson(taskDetail, subtaskDetails);
        taskList.add(pw);
      } else if (taskName == 'Sentence Matching') {
        SM sm = new SM.fromJson(taskDetail, subtaskDetails);
        taskList.add(sm);
      } else if (taskName == 'Jumbled Sentence') {
        JS js = new JS.fromJson(taskDetail, subtaskDetails);
        taskList.add(js);
      } else if (taskName == 'Fill in the Blanks') {
        FB fb = new FB.fromJson(taskDetail, subtaskDetails);
        taskList.add(fb);
      } else if (taskName == 'MCQ') {
        MCQ mcq = new MCQ.fromJson(taskDetail, subtaskDetails);
        taskList.add(mcq);
      } else if (taskName == 'Error in Sentence') {
        Error error = new Error.fromJson(taskDetail, subtaskDetails);
        taskList.add(error);
      }
      // pw.downloadImage(pw.image);

    }
    // //Returns a topic task list;
    // return taskList;
    return new TaskList(taskList: taskList, taskName: taskName);
  }
}

class TopicTask {
  int _taskId;
  int _topicId;
  int _level;
  String _taskName;
  String _instruction;
  String _instructionImage;
  String _exerciseInstructions;

  //New fields
  int _shId;
  int _shTaskId;
  int _userId;
  bool _solvedStatus;
  bool _attempted;
  bool _deleted;

  set taskId(int value) => this._taskId = value;

  get taskId => this._taskId;

  set instruction(value) => this._instruction = value;

  get instruction => this._instruction;

  set instructionImage(value) => this._instructionImage = value;

  get instructionImage => this._instructionImage;

  set exerciseInstructions(value) => this._exerciseInstructions = value;

  get exerciseInstructions => this._exerciseInstructions;

  get level => this._level;

  set level(int value) => this._level = value;

  get taskName => this._taskName;

  set taskName(value) => this._taskName = value;

  get topicId => this._topicId;

  set topicId(value) => this._topicId = value;

  get shId => this._shId;

  set shId(value) => this._shId = value;

  get shTaskId => this._shTaskId;

  set shTaskId(value) => this._shTaskId = value;

  get userId => this._userId;

  set userId(value) => this._userId = value;

  get solvedStatus => this._solvedStatus;

  set solvedStatus(value) => this._solvedStatus = value;

  get attempted => this._attempted;

  set attempted(value) => this._attempted = value;

  TopicTask({
    int taskId,
    int level,
    String taskName,
    int topicId,
    String instruction,
    String instructionImage,
    String exerciseInstructions,
    int shId,
    int shTaskId,
    int userId,
    bool solvedStatus,
    bool attempted,
    bool deleted,
  })  : _taskId = taskId,
        _level = level,
        _taskName = taskName,
        _topicId = topicId,
        _instruction = instruction,
        _instructionImage = instructionImage,
        _exerciseInstructions = exerciseInstructions,
        _shId = shId,
        _shTaskId = shTaskId,
        _userId = userId,
        _solvedStatus = solvedStatus,
        _attempted = attempted,
        _deleted = deleted;

  Map<String, dynamic> toTask() {
    Map<String, dynamic> map = new Map();

    map['TopicTaskId'] = taskId;
    map['TaskType'] = taskName;
    map['TopicId'] = topicId;
    map['Level'] = level;
    map['Instruction'] = instruction;
    map['Instruction_Image'] = instructionImage;
    map['ExerciseInstructions'] = exerciseInstructions;
    // map['UserId'] = userId;
    // map['SolvedStatus'] = solvedStatus == true ? 1 : 0;
    // map['Attempted'] = attempted == true ? 1: 0;

    return map;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map['task_id'] = taskId;
    map['topic_id'] = topicId;
    map['level'] = level;
    map['name'] = taskName;
    map['instruction'] = instruction;
    map['instructionImage'] = instructionImage;
    map['exerciseInstructions'] = exerciseInstructions;

    return map;
  }

  factory TopicTask.fromDatabase(Map<String, dynamic> json) {
    return new TopicTask(
      taskId: json['TopicTaskId'],
      topicId: json['TopicId'],
      level: json['Level'],
      taskName: json['TaskType'],
      instruction: json['Instruction'],
      instructionImage: json['Instruction_Image'],
      exerciseInstructions: json['ExerciseInstructions'],
    );
  }

  void debugTaskMessage() {
    print("Task_Id: " + taskId.toString());
    print("Level: " + level.toString());
    print("Taskname: " + taskName);
    print("TopicId: " + topicId.toString());
  }
}

class SubTask extends TopicTask {
  //int _taskId;
  int _subtaskId;

  int get subtaskId => this._subtaskId;

  set subtaskId(int value) => this._subtaskId = value;

  SubTask(
      {int taskId,
      int subtaskId,
      int level,
      int topicId,
      String taskName,
      String instruction,
      String instructionImage,
      String exerciseInstructions})
      : _subtaskId = subtaskId,
        super(
            taskId: taskId,
            level: level,
            topicId: topicId,
            taskName: taskName,
            instruction: instruction,
            instructionImage: instructionImage,
            exerciseInstructions: exerciseInstructions);

  Map<String, dynamic> toSubTask() {
    Map<String, dynamic> map = new Map();

    map['SubtaskId'] = subtaskId;
    map['TopicTaskId'] = taskId;

    return map;
  }
}
