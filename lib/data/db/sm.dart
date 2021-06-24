import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/sm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class SMDatabaseHelper{
  SMDatabaseHelper._createInstance();
  static final SMDatabaseHelper _instance = new SMDatabaseHelper._createInstance();

  factory SMDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  final TaskDatabaseHelper _taskDatabaseHelper = new TaskDatabaseHelper();

  //PW Table
  String _smTable='Sentence Matching';
  String _smId='smId';
  String _smLeftPart='Left_Part';
  String _smRightPart='Right_Part';
  String _smExplanation='Explanation';

  
  Future<List<SM> >getSMList(int topicId,int level,{int limit,int offset}) async{
    var database= await _databaseHelper.database; 

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<int>taskIds=[];
    List<SM>results=[];

    List<Map<String,dynamic> >taskDetails=await _taskDatabaseHelper.getTaskDetails(topicId, level,'Sentence Matching',limit:limit,offset: offset);
    
    print("In Db helper");
    print(taskDetails.length);

    String taskTableId=_taskDatabaseHelper.taskTableId;
    
    for(Map<String,dynamic>taskDetail in taskDetails)
    {
      int taskId=taskDetail[taskTableId];
      //print(taskId);
      List<Map<String,dynamic> >questionDetails= await database.query('''
                                                                      $subtaskTable INNER JOIN $_smTable ON
                                                                      $subtaskTable.$subtaskId = $_smTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_smId,_smLeftPart,_smExplanation,_smRightPart],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
                                                                      );

      for(Map<String,dynamic>questionDetail in questionDetails)
        results.add(new SM.fromDatabase(taskDetail, questionDetail));
      
    }

    return results;

  }

  //insert topics
  Future<int>insertSM(Map<String,dynamic>sm) async{
    var database= await _databaseHelper.database;
    return await database.insert(_smTable,sm,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updateSM(Map<String,dynamic>sm,int smId) async{
    var database = await _databaseHelper.database;
    return await database.update(_smTable, sm,where: '$_smId = ?',whereArgs: [smId]);
  }
}