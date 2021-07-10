import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/js.dart';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class JSDatabaseHelper{
  JSDatabaseHelper._createInstance();
  static final JSDatabaseHelper _instance = new JSDatabaseHelper._createInstance();

  factory JSDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  final TaskDatabaseHelper _taskDatabaseHelper = new TaskDatabaseHelper();


  //JS Table
  String _jsTable='Jumbled_Sentence';
  String _jsId='jsId';
  String _jsSentence='Sentence';
  String _jsAnswer='Answer';
  String _jsExplanation='Explanation';

  Future<List<JS> >getJSList(int topicId,int level,{int limit,int offset}) async{
    var database= await _databaseHelper.database; 

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<int>taskIds=[];
    List<JS>results=[];

    List<Map<String,dynamic> >taskDetails=await _taskDatabaseHelper.getTaskDetails(topicId, level,'Jumbled Sentence',limit:limit,offset: offset);
    
    print("In Db helper");
    print(taskDetails.length);

    String taskTableId=_taskDatabaseHelper.taskTableId;
    
    for(Map<String,dynamic>taskDetail in taskDetails)
    {
      int taskId=taskDetail[taskTableId];
      //print(taskId);
      List<Map<String,dynamic> >questionDetails= await database.query('''
                                                                      $subtaskTable INNER JOIN $_jsTable ON
                                                                      $subtaskTable.$subtaskId = $_jsTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_jsId,_jsSentence,_jsAnswer,_jsExplanation],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
                                                                      );

      for(Map<String,dynamic>questionDetail in questionDetails)
        results.add(new JS.fromDatabase(taskDetail, questionDetail));
      
    }

    return results;

  }

  Future<List<JS> >getJSs(int topicId,int level,TopicTask task,{int limit,int offset})async
  { 

    var database= await _databaseHelper.database; 

    Map<String,dynamic>taskDetail=task.toTask();

    String taskTableId = _taskDatabaseHelper.taskTableId;
    int taskId=taskDetail[taskTableId];
    // print("Task :"+taskId.toString());

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<JS>results=[];

    List<Map<String,dynamic> >questionDetails = await database.query('''
                                                                      $subtaskTable INNER JOIN $_jsTable ON
                                                                      $subtaskTable.$subtaskId = $_jsTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_jsId,_jsSentence,_jsAnswer,_jsExplanation],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
    );

    print("Length :"+questionDetails.length.toString());

    for(Map<String,dynamic>questionDetail in questionDetails)
    {
      JS js = new JS.fromDatabase(taskDetail, questionDetail);
      
      results.add(js);
    }
      
    return results;
  }


  //insert topics
  Future<int>insertJS(Map<String,dynamic>js) async{
    var database= await _databaseHelper.database;
    return await database.insert(_jsTable,js,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updateJS(Map<String,dynamic>js,int jsId) async{
    var database = await _databaseHelper.database;
    return await database.update(_jsTable, js,where: '$_jsId = ?',whereArgs: [jsId]);
  }
}