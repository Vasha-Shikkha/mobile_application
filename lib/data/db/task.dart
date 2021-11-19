import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class TaskDatabaseHelper {
  TaskDatabaseHelper._createInstance();
  static final TaskDatabaseHelper _instance =
      new TaskDatabaseHelper._createInstance();

  factory TaskDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();

  String _topicTaskTable = 'TopicTask';
  String _taskTableId = 'TopicTaskId';
  String _taskType = 'TaskType';
  String _topicId = 'TopicId';
  String _level = 'Level';
  String _taskInstruction = 'Instruction';
  String _taskInstructionImage = 'Instruction_Image';
  String _taskExerciseInstructions = 'ExerciseInstructions';

  //Subtask Table
  String _subtaskTable = 'Subtasks';
  String _subtaskId = 'SubtaskId';

  String get topicTaskTable => this._topicTaskTable;

  set topicTaskTable(String value) => this._topicTaskTable = value;

  get taskTableId => this._taskTableId;

  set taskTableId(value) => this._taskTableId = value;

  get taskType => this._taskType;

  set taskType(value) => this._taskType = value;

  get topicId => this._topicId;

  set topicId(value) => this._topicId = value;

  get level => this._level;

  set level(value) => this._level = value;

  get taskInstruction => this._taskInstruction;

  set taskInstruction(value) => this._taskInstruction = value;

  get taskInstructionImage => this._taskInstructionImage;

  set taskInstructionImage(value) => this._taskInstructionImage = value;

  get subtaskTable => this._subtaskTable;

  set subtaskTable(value) => this._subtaskTable = value;

  get subtaskId => this._subtaskId;

  set subtaskId(value) => this._subtaskId = value;

  get taskExerciseInstructions => this._taskExerciseInstructions;

  set taskExerciseInstructions(value) => this._taskExerciseInstructions = value;

  Future<List<Map<String, dynamic>>> getTaskDetails(
      int topicId, int level, String taskName,
      {int limit, int offset}) async {
    var database = await _databaseHelper.database;

    List<Map<String, dynamic>> taskDetails = await database.query(
        '''
                                                                $_topicTaskTable INNER JOIN $_subtaskTable ON
                                                                $_topicTaskTable.$_taskTableId = $_subtaskTable.$_taskTableId
                                                                ''',
        columns: [
          '$topicTaskTable.$taskTableId',
          taskType,
          _topicId,
          taskInstruction,
          taskInstructionImage,
          _level,
          taskExerciseInstructions
        ],
        where: '$_taskType = ? and $_level = ? and $_topicId = ?',
        whereArgs: [taskName, level, topicId],
        limit: limit,
        offset: offset);

    return taskDetails;
  }

  Future<List<TopicTask>> getTasks(int topicId, int level,
      {int limit, int offset}) async {
    var database = await _databaseHelper.database;

    List<Map<String, dynamic>> tasks = await database.query(_topicTaskTable,
        columns: [
          taskTableId,
          taskType,
          _topicId,
          taskInstruction,
          taskInstructionImage,
          taskExerciseInstructions,
          _level
        ],
        where: '$_level = ? and $_topicId = ?',
        whereArgs: [level, topicId],
        orderBy: '$taskTableId ASC',
        limit: limit,
        offset: offset);

    print("Hello World");

    List<TopicTask> taskDetails = [];
    for (Map<String, dynamic> element in tasks)
      taskDetails.add(new TopicTask.fromDatabase(element));

    return taskDetails;
  }

  Future<int> getCount(String taskName, int topicId) async {
    var database = await _databaseHelper.database;
    List<Map<String, dynamic>> x = await database.rawQuery(
        'SELECT COUNT(*) FROM $topicTaskTable where $taskType = "$taskName" and $_topicId=$topicId');
    //"Fill in the Blanks"
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount2(int topicId, level, limit, offset) async {
    var database = await _databaseHelper.database;
    int offsetNo = offset * 10;
    List<Map<String, dynamic>> x = await database.rawQuery(
        'SELECT COUNT(*) FROM $topicTaskTable where $_topicId=$topicId LIMIT $limit OFFSET $offsetNo');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<bool> entryExists(int taskId) async {
    var database = await _databaseHelper.database;
    List<Map<String, dynamic>> x = await database.rawQuery(
        'SELECT COUNT(*) FROM $topicTaskTable where $_taskTableId=$taskId');
    int count = Sqflite.firstIntValue(x);
    if (count == 0)
      return false;
    else
      return true;
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    var database = await _databaseHelper.database;
    // int taskId=task['TopicTaskId'];
    // bool exists=await entryExists(taskId);
    // if(exists==false)
    // {
    //   print("Inserted");
    //   return await database.insert(topicTaskTable,task);
    // }
    // else
    //   return -1;
    return await database.insert(topicTaskTable, task,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertSubTask(Map<String, dynamic> subTask) async {
    var database = await _databaseHelper.database;
    return await database.insert(subtaskTable, subTask,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
