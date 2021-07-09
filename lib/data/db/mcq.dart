import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/mcq.dart';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class MCQDatabaseHelper{
  MCQDatabaseHelper._createInstance();
  static final MCQDatabaseHelper _instance = new MCQDatabaseHelper._createInstance();

  factory MCQDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  final TaskDatabaseHelper _taskDatabaseHelper = new TaskDatabaseHelper();


  //MCQ Table
  String _mcqTable='MCQ';
  String _mcqId='mcqId';
  String _mcqQuestion='Question';
  String _mcqAnswer='Answer';
  String _mcqExplanation='Explanation';
  String _mcqOptions='Options';

  Future<List<MCQ> >getMCQList(int topicId,int level,{int limit,int offset}) async{
    var database= await _databaseHelper.database; 

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<int>taskIds=[];
    List<MCQ>results=[];

    List<Map<String,dynamic> >taskDetails=await _taskDatabaseHelper.getTaskDetails(topicId, level,'MCQ',limit:limit,offset: offset);
    
    print("In Db helper");
    print(taskDetails.length);

    String taskTableId=_taskDatabaseHelper.taskTableId;
    
    for(Map<String,dynamic>taskDetail in taskDetails)
    {
      int taskId=taskDetail[taskTableId];
      //print(taskId);
      List<Map<String,dynamic> >questionDetails= await database.query('''
                                                                      $subtaskTable INNER JOIN $_mcqTable ON
                                                                      $subtaskTable.$subtaskId = $_mcqTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_mcqId,_mcqQuestion,_mcqAnswer,_mcqExplanation,_mcqOptions],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
                                                                      );

      for(Map<String,dynamic>questionDetail in questionDetails)
        results.add(new MCQ.fromDatabase(taskDetail, questionDetail));
      
      
      //Map<String,dynamic> questionDetail=questionDetails[0];
      
      //print("Length of list: "+questionDetails.length.toString());
      //taskIds.add(taskId);
      
      
    
    }

    return results;

  }

  Future<List<MCQ> >getMCQs(int topicId,int level,TopicTask task,{int limit,int offset})async
  { 

    var database= await _databaseHelper.database; 

    Map<String,dynamic>taskDetail=task.toTask();

    String taskTableId = _taskDatabaseHelper.taskTableId;
    int taskId=taskDetail[taskTableId];
    // print("Task :"+taskId.toString());

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<MCQ>results=[];

    List<Map<String,dynamic> >questionDetails = await database.query('''
                                                                      $subtaskTable INNER JOIN $_mcqTable ON
                                                                      $subtaskTable.$subtaskId = $_mcqTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_mcqId,_mcqQuestion,_mcqAnswer,_mcqExplanation,_mcqOptions],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
    );

    print("Length :"+questionDetails.length.toString());

    for(Map<String,dynamic>questionDetail in questionDetails)
    {
      MCQ mcq = new MCQ.fromDatabase(taskDetail, questionDetail);
      
      results.add(mcq);
    }
      
    return results;
  }


  //insert topics
  Future<int>insertMCQ(Map<String,dynamic>mcq) async{
    var database= await _databaseHelper.database;
    return await database.insert(_mcqTable,mcq,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updateMCQ(Map<String,dynamic>mcq,int mcqId) async{
    var database = await _databaseHelper.database;
    return await database.update(_mcqTable, mcq,where: '$_mcqId = ?',whereArgs: [mcqId]);
  }
}