import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/fb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class FBDatabaseHelper{
  FBDatabaseHelper._createInstance();
  static final FBDatabaseHelper _instance = new FBDatabaseHelper._createInstance();

  factory FBDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  final TaskDatabaseHelper _taskDatabaseHelper = new TaskDatabaseHelper();


  //FB Table
  String _fbTable='FB';
  String _fbId='fbId';
  String _paragraph='Paragraph';
  String _options='Options';
  String _answers='Answers';
  String _explanations='Explanations';
  

  Future<List<FB> >getFBList(int topicId,int level,{int limit,int offset}) async{
    var database= await _databaseHelper.database; 

    String subtaskTable=_taskDatabaseHelper.subtaskTable;
    String subtaskId=_taskDatabaseHelper.subtaskId;

    List<int>taskIds=[];
    List<FB>results=[];

    List<Map<String,dynamic> >taskDetails=await _taskDatabaseHelper.getTaskDetails(topicId, level,'Fill in the Blanks',limit: limit,offset: offset);

    String taskTableId=_taskDatabaseHelper.taskTableId;
    
    for(Map<String,dynamic>taskDetail in taskDetails)
    {
      int taskId=taskDetail[taskTableId];
      
      List<Map<String,dynamic> >questionDetails= await database.query('''
                                                                      $subtaskTable INNER JOIN $_fbTable ON
                                                                      $subtaskTable.$subtaskId = $_fbTable.$subtaskId
                                                                      '''
                                                                      ,columns: ['$subtaskTable.$subtaskId',_fbId,_paragraph,_options,_answers,_explanations],
                                                                      where:'$subtaskTable.$taskTableId=?',
                                                                      whereArgs:[taskId]
                                                                      );

      for(Map<String,dynamic>questionDetail in questionDetails)
        results.add(new FB.fromDatabase(taskDetail, questionDetail));
      /*
      Map<String,dynamic> questionDetail=questionDetails[0];
      
      print("Length of list: "+questionDetails.length.toString());
      taskIds.add(taskId);
      
      results.add(new FB.fromDatabase(taskDetail, questionDetail));
      */
    }

    return results;

  }

  //insert topics
  Future<int>insertFB(Map<String,dynamic>fb) async{
    var database= await _databaseHelper.database;
    return await database.insert(_fbTable,fb,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updateFB(Map<String,dynamic>fb,int fbId) async{
    var database = await _databaseHelper.database;
    return await database.update(_fbTable, fb,where: '$_fbId = ?',whereArgs: [fbId]);
  }
}