import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/pw.dart';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class PWDatabaseHelper{
  PWDatabaseHelper._createInstance();
  static final PWDatabaseHelper _instance = new PWDatabaseHelper._createInstance();

  factory PWDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  final TaskDatabaseHelper _taskDatabaseHelper = new TaskDatabaseHelper();

  //PW Table
  String _pwTable='Picture_to_Word';
  String _pwId='pwId';
  String _pwQuestion='Question';
  String _pwImage='Image';
  String _pwAnswer='Answer';
  String _pwOptions='Options';
  String _pwExplanation='Explanation';

  
  Future<List<PW> >getPWList(int topicId,int level,{int limit,int offset}) async{
    var database= await _databaseHelper.database; 

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<int>taskIds=[];
    List<PW>results=[];

    List<Map<String,dynamic> >taskDetails=await _taskDatabaseHelper.getTaskDetails(topicId, level,'Picture to Word',limit:limit,offset: offset);
    
    print("In Db helper");
    print(taskDetails.length);

    String taskTableId=_taskDatabaseHelper.taskTableId;
    
    for(Map<String,dynamic>taskDetail in taskDetails)
    {
      int taskId=taskDetail[taskTableId];
      //print(taskId);
      List<Map<String,dynamic> >questionDetails= await database.query('''
                                                                      $subtaskTable INNER JOIN $_pwTable ON
                                                                      $subtaskTable.$subtaskId = $_pwTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_pwId,_pwQuestion,_pwAnswer,_pwExplanation,_pwImage, _pwOptions],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
                                                                      );

      for(Map<String,dynamic>questionDetail in questionDetails)
        results.add(new PW.fromDatabase(taskDetail, questionDetail));
      
    }

    return results;

  }

  Future<List<PW> >getPWs(int topicId,int level,TopicTask task,{int limit,int offset})async
  { 

    var database= await _databaseHelper.database; 

    Map<String,dynamic>taskDetail=task.toTask();

    String taskTableId = _taskDatabaseHelper.taskTableId;
    int taskId=taskDetail[taskTableId];
    // print("Task :"+taskId.toString());

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<PW>results=[];

    List<Map<String,dynamic> >questionDetails = await database.query('''
                                                                      $subtaskTable INNER JOIN $_pwTable ON
                                                                      $subtaskTable.$subtaskId = $_pwTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_pwId,_pwQuestion,_pwAnswer,_pwExplanation,_pwImage, _pwOptions],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
    );

    print("Length :"+questionDetails.length.toString());

    for(Map<String,dynamic>questionDetail in questionDetails)
    {
      PW pw = new PW.fromDatabase(taskDetail, questionDetail);
      // pw.debugMessage();
      results.add(pw);
    }
      // results.add(new PW.fromDatabase(taskDetail, questionDetail));
    return results;
  }

  //insert topics
  Future<int>insertPW(Map<String,dynamic>pw) async{
    var database= await _databaseHelper.database;
    return await database.insert(_pwTable,pw,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updatePW(Map<String,dynamic>pw,int pwId) async{
    var database = await _databaseHelper.database;
    return await database.update(_pwTable, pw,where: '$_pwId = ?',whereArgs: [pwId]);
  }
}