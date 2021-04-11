import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/topic.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class TopicDatabaseHelper{
  
  TopicDatabaseHelper._createInstance();
  static final TopicDatabaseHelper _instance = new TopicDatabaseHelper._createInstance();

  factory TopicDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();

  String _topicTable= 'Topic';
  String _topicId = 'TopicId';
  String _topicName = 'TopicName';
  String _topicType = 'TopicType';
  String _topicImage = 'TopicImage';

  //TopicLevelCount
  String _countTable='TopicLevelCount';
  String _levelCountId='TopicLevelCountId';
  String _topicIdFK='TopicId';
  String _level='Level';
  String _exerciseCount='Count';

  Future<List<Topic>> getTypeTopicList(String topicType) async{
    var database = await _databaseHelper.database;

    List<Map<String,dynamic> >result = await database.query(_topicTable,
                                      columns: [_topicId,_topicName,_topicType],
                                      where:'$_topicType = ? _level',
                                      whereArgs: [topicType]);
    
    List<Topic>topicList = [];
    for(int i=0;i<result.length;i++)
      topicList.add(new Topic.fromDatabase(result[i]));
    
    return topicList;
  
  }

  Future<List<Topic>>getTopics(String topicType, int level) async{
    var database = await _databaseHelper.database;
    
    List<Map<String,dynamic>> result = await database.query('''
                                                            $_topicTable inner join $_countTable on 
                                                            $_topicTable.$_topicId = $_countTable.$_topicIdFK
                                                            ''',
                                                            columns: [_topicId,_topicName],
                                                            where:'$_topicType = ? and $_level = ? and count>0',
                                                            whereArgs: [topicType,level]
                                                            );
    
    List<Topic>topicList = [];
    for(int i=0;i<result.length;i++)
      topicList.add(new Topic.fromDatabase(result[i])); 
  
    return topicList;
  }

  Future<int> getCount() async{
    var database = await _databaseHelper.database;
    List<Map<String,dynamic>> x = await database.rawQuery('SELECT COUNT(*) FROM $_topicTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //insert topics
  Future<int>insertTopic(Map<String,dynamic>topic) async{
    var database= await _databaseHelper.database;
    return await database.insert(_topicTable,topic,conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //update topics
  Future<int>updateTopic(Map<String,dynamic>topic,int topicId) async{
    var database = await _databaseHelper.database;
    return await database.update(_topicTable, topic,where: '$_topicId = ?',whereArgs: [topicId]);
  }

  //delete topics (this might not be used. Who knows)
  Future<int>deleteTopic(int topicId) async{
    var database = await _databaseHelper.database;
    return await database.delete(_topicTable, where:'$_topicId= ?',whereArgs: [topicId]);
  }

  //insert TopicLevelCount
  Future<int>insertTopicLevelCount(Map<String,dynamic>topicLevelCount) async{
    var database=await _databaseHelper.database;
    return await database.insert(_countTable,topicLevelCount,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //update TopicLevelCount
  Future<int>updateTopicLevelCount(Map<String,dynamic>topicLevelCount, int topicLevelCountId) async{
    var database=await _databaseHelper.database;
    return await database.update(_countTable,topicLevelCount,where:'$_levelCountId = ?',whereArgs: [topicLevelCountId]);
  }

  //delete TopicLevelCount
  Future<int>deleteTopicLevelCount(int topicLevelCountId) async{
    var database = await _databaseHelper.database;
    return await database.delete(_countTable,where:'$_levelCountId = ?',whereArgs: [topicLevelCountId]);
  }
}