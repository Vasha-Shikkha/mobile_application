import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/error.dart';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class ErrorDatabaseHelper{
  ErrorDatabaseHelper._createInstance();
  static final ErrorDatabaseHelper _instance = new ErrorDatabaseHelper._createInstance();

  factory ErrorDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  final TaskDatabaseHelper _taskDatabaseHelper = new TaskDatabaseHelper();


  //MCQ Table
  String _errorTable='Error_In_Sentence';
  String _errorId='errorId';
  String _errorQuestion='Question';
  String _errorOptions='Options';
  String _errorAnswer='Answer';
  String _errorExplanation='Explanation';
  
  
  Future<List<Error> >getErrorList(int topicId,int level,{int limit,int offset}) async{
    var database= await _databaseHelper.database; 

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<int>taskIds=[];
    List<Error>results=[];

    List<Map<String,dynamic> >taskDetails=await _taskDatabaseHelper.getTaskDetails(topicId, level,'Error In Sentence',limit:limit,offset: offset);
    
    print("In Db helper");
    print(taskDetails.length);

    String taskTableId=_taskDatabaseHelper.taskTableId;
    
    for(Map<String,dynamic>taskDetail in taskDetails)
    {
      int taskId=taskDetail[taskTableId];
      //print(taskId);
      List<Map<String,dynamic> >questionDetails= await database.query('''
                                                                      $subtaskTable INNER JOIN $_errorTable ON
                                                                      $subtaskTable.$subtaskId = $_errorTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_errorId,_errorQuestion,_errorAnswer,_errorExplanation,_errorOptions],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
                                                                      );

      for(Map<String,dynamic>questionDetail in questionDetails)
        results.add(new Error.fromDatabase(taskDetail, questionDetail));
      
      
      //Map<String,dynamic> questionDetail=questionDetails[0];
      
      //print("Length of list: "+questionDetails.length.toString());
      //taskIds.add(taskId);
      
      
    
    }

    return results;

  }

  Future<List<Error> >getErrors(int topicId,int level,TopicTask task,{int limit,int offset})async
  { 

    var database= await _databaseHelper.database; 

    Map<String,dynamic>taskDetail=task.toTask();

    String taskTableId = _taskDatabaseHelper.taskTableId;
    int taskId=taskDetail[taskTableId];
    // print("Task :"+taskId.toString());

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<Error>results=[];

    List<Map<String,dynamic> >questionDetails = await database.query('''
                                                                      $subtaskTable INNER JOIN $_errorTable ON
                                                                      $subtaskTable.$subtaskId = $_errorTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_errorId,_errorQuestion,_errorAnswer,_errorExplanation,_errorOptions],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
    );

    print("Length :"+questionDetails.length.toString());

    for(Map<String,dynamic>questionDetail in questionDetails)
    {
      Error error = new Error.fromDatabase(taskDetail, questionDetail);
      
      results.add(error);
    }
      
    return results;
  }


  //insert topics
  Future<int>insertError(Map<String,dynamic>error) async{
    var database= await _databaseHelper.database;
    return await database.insert(_errorTable,error,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updateError(Map<String,dynamic>mcq,int errorId) async{
    var database = await _databaseHelper.database;
    return await database.update(_errorTable, mcq,where: '$_errorId = ?',whereArgs: [errorId]);
  }
}