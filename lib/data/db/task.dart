import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/fb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class TaskDatabaseHelper{
  
  TaskDatabaseHelper._createInstance();
  static final TaskDatabaseHelper _instance = new TaskDatabaseHelper._createInstance();

  factory TaskDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();

  String _topicTaskTable='TopicTask';
  String _taskTableId='TopicTaskId';
  String _taskType='TaskType';
  String _topicId='TopicId';
  String _level='Level';
  String _taskInstruction='Instruction';
  String _taskInstructionImage='Instruction_Image';

  //Subtask Table
  String _subtaskTable='Subtasks';
  String _subtaskId='SubtaskId';

  String get topicTaskTable => this._topicTaskTable;

  set topicTaskTable(String value) => this._topicTaskTable = value;

  get taskTableId => this._taskTableId;

  set taskTableId( value) => this._taskTableId = value;

  get taskType => this._taskType;

  set taskType( value) => this._taskType = value;

  get topicId => this._topicId;

  set topicId( value) => this._topicId = value;

  get level => this._level;

  set level( value) => this._level = value;

  get taskInstruction => this._taskInstruction;

  set taskInstruction( value) => this._taskInstruction = value;

  get taskInstructionImage => this._taskInstructionImage;

  set taskInstructionImage( value) => this._taskInstructionImage = value;

  get subtaskTable => this._subtaskTable;

  set subtaskTable( value) => this._subtaskTable = value;

  get subtaskId => this._subtaskId;

  set subtaskId( value) => this._subtaskId = value;

  Future <List<Map<String,dynamic> >>getTaskDetails(int topicId,int level,String taskName,{int limit,int offset}) async{
    var database= await _databaseHelper.database;

    List<Map<String,dynamic> >taskDetails= await database.query('''
                                                                $_topicTaskTable INNER JOIN $_subtaskTable ON
                                                                $_topicTaskTable.$_taskTableId = $_subtaskTable.$_taskTableId
                                                                ''',
                                                                columns: ['$topicTaskTable.$taskTableId',taskType,_topicId,taskInstruction,taskInstructionImage,_level],
                                                                where: '$_taskType = ? and $_level = ? and $_topicId = ?',
                                                                whereArgs: [taskName,level,topicId],
                                                                limit: limit,
                                                                offset: offset
                                                                );
  
    return taskDetails;
  }

  Future<int>getCount(String taskName,int topicId)async{
    var database= await _databaseHelper.database;
    List<Map<String,dynamic>> x = await database.rawQuery('SELECT COUNT(*) FROM $topicTaskTable where $taskType = "$taskName" and $_topicId=$topicId');
    //"Fill in the Blanks"
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int>insertTask(Map<String,dynamic>task) async
  {
    var database= await _databaseHelper.database;
    return await database.insert(topicTaskTable,task,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int>insertSubTask(Map<String,dynamic>subTask) async
  {
    var database= await _databaseHelper.database;
    return await database.insert(subtaskTable,subTask,conflictAlgorithm: ConflictAlgorithm.replace);
  }
}