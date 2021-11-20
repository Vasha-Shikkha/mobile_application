import 'task.dart';

class SMList extends TaskList {
  List<SM> _smList;

  List<SM> get smList => this._smList;

  set smList(List<SM> value) => this._smList = value;

  Map<String, dynamic> getParts(List<SM> list) {
    List<String> partOne = [];
    List<String> partTwo = [];
    List<String> explanations = [];

    for (SM sm in list) {
      partOne.add(sm.partOne);
      partTwo.add(sm.partTwo);

      if (sm.explanation == null)
        explanations.add('');
      else
        explanations.add(sm.explanation);
    }

    Map<String, dynamic> map = new Map();
    map['PartOne'] = partOne;
    map['PartTwo'] = partTwo;
    map['Explanations'] = explanations;

    return map;
  }

  SMList({List<SM> smList}) : _smList = smList;

  factory SMList.fromJson(List<dynamic> json) {
    List<SM> smList = [];
    for (dynamic element in json) {
      Map<String, dynamic> taskDetail = element['taskDetail'];
      List<dynamic> questions = element['questions'];

      for (Map<String, dynamic> question in questions) {
        SM sm = new SM.fromJson(taskDetail, question);
        smList.add(sm);
      }
    }

    // print(pwList.length);

    return new SMList(smList: smList);
  }
}

class SM extends SubTask {
  int _id;
  String _partOne;
  String _partTwo;
  String _explanation;

  get id => this._id;

  set id(value) => this._id = value;

  get partOne => this._partOne;

  set partOne(value) => this._partOne = value;

  get partTwo => this._partTwo;

  set partTwo(value) => this._partTwo = value;

  get explanation => this._explanation;

  set explanation(value) => this._explanation = value;

  SM({
    int id,
    int subtaskId,
    int taskId,
    int level,
    int topicId,
    String taskName,
    String instruction,
    String instructionImage,
    String exerciseInstructions,
    String partOne,
    String partTwo,
    String explanation,
  })  : _id = id,
        _explanation = explanation,
        _partOne = partOne,
        _partTwo = partTwo,
        super(
            taskId: taskId,
            subtaskId: subtaskId,
            level: level,
            topicId: topicId,
            taskName: taskName,
            instruction: instruction,
            instructionImage: instructionImage,
            exerciseInstructions: exerciseInstructions);

  factory SM.fromJson(
      Map<String, dynamic> taskDetail, Map<String, dynamic> question) {
    //Map<String,dynamic>taskDetails= json['taskDetail'];
    //List<Map<String,dynamic> >questions

    return new SM(
      //id : question['id'],
      partOne: question['part_one'],
      partTwo: question['part_two'],
      explanation: question['explanation'],
      taskId: taskDetail['task_id'],
      topicId: taskDetail['topic_id'],
      subtaskId: question['subTaskId'],
      level: taskDetail['level'],
      taskName: taskDetail['name'],
      instruction:
          taskDetail['instruction'] == null ? "" : taskDetail['instruction'],
      instructionImage: taskDetail['instructionImage'] == null
          ? ""
          : taskDetail['instructionImage'],
      exerciseInstructions: taskDetail['exerciseInstructions'] == null
          ? ""
          : taskDetail['exerciseInstructions'],
    );
  }

  Map<String, dynamic> toSM() {
    Map<String, dynamic> map = new Map();
    if (id != null) map['smId'] = id;
    map['PartOne'] = partOne;
    map['PartTwo'] = partTwo;
    map['Explanation'] = explanation;
    map['SubtaskId'] = subtaskId;

    return map;
  }

  void debugMessage() {
    print("Task_Id: " + taskId.toString());
    print("Level: " + level.toString());
    print("Taskname: " + taskName);
    print("TopicId: " + topicId.toString());
    print("SubtaskId: " + subtaskId.toString());
    if (id != null) print("smId: " + id.toString());
    print("PartOne: " + partOne.toString());
    print("PartTwo: " + partTwo.toString());
  }

  factory SM.fromDatabase(
      Map<String, dynamic> taskDetails, Map<String, dynamic> questions) {
    return new SM(
        id: questions['smId'],
        partOne: questions['PartOne'],
        partTwo: questions['PartTwo'],
        explanation: questions['Explanation'],
        taskId: taskDetails['TopicTaskId'],
        subtaskId: questions['SubtaskId'],
        level: taskDetails['Level'],
        topicId: taskDetails['TopicId'],
        taskName: taskDetails['TaskType'],
        instruction: taskDetails['Instruction'],
        instructionImage: taskDetails['Instruction_Image'],
        exerciseInstructions: taskDetails['ExerciseInstructions']);
  }
}
