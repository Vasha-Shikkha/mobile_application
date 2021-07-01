import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/wp.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class WPDatabaseHelper{
  WPDatabaseHelper._createInstance();
  static final WPDatabaseHelper _instance = new WPDatabaseHelper._createInstance();

  factory WPDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  final TaskDatabaseHelper _taskDatabaseHelper = new TaskDatabaseHelper();

  //WP Table
  String _wpTable='Word_to_Picture';
  String _wpId='wpId';
  String _wpQuestion='Question';
  String _wpImages='Images';
  String _wpAnswer='Answer';
  String _wpExplanation='Explanation';

  
  Future<List<WP> >getWPList(int topicId,int level,{int limit,int offset}) async{
    var database= await _databaseHelper.database; 

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<int>taskIds=[];
    List<WP>results=[];

    List<Map<String,dynamic> >taskDetails=await _taskDatabaseHelper.getTaskDetails(topicId, level,'Word to Picture',limit:limit,offset: offset);
    
    print("In Db helper");
    print(taskDetails.length);

    String taskTableId=_taskDatabaseHelper.taskTableId;
    
    for(Map<String,dynamic>taskDetail in taskDetails)
    {
      int taskId=taskDetail[taskTableId];
      //print(taskId);
      List<Map<String,dynamic> >questionDetails= await database.query('''
                                                                      $subtaskTable INNER JOIN $_wpTable ON
                                                                      $subtaskTable.$subtaskId = $_wpTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_wpId,_wpQuestion,_wpAnswer,_wpExplanation,_wpImages],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
                                                                      );

      for(Map<String,dynamic>questionDetail in questionDetails)
        results.add(new WP.fromDatabase(taskDetail, questionDetail));
      
    }

    return results;

  }

  //insert topics
  Future<int>insertWP(Map<String,dynamic>wp) async{
    var database= await _databaseHelper.database;
    return await database.insert(_wpTable,wp,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updateWP(Map<String,dynamic>wp,int wpId) async{
    var database = await _databaseHelper.database;
    return await database.update(_wpTable, wp,where: '$_wpId = ?',whereArgs: [wpId]);
  }
}