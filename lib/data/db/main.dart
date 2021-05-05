import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//These two imports are for web only

//import 'package:sqflite_web/sqflite_web.dart';
//import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';

//import 'package:notebuddy/models/note.dart';

class MainDatabaseHelper {

  static final _dbName='vs.db';
  static final _dbVersion=1;  
  
  MainDatabaseHelper._createInstance(); //NAMED CONST TO CREATE INSTANCE OF THE DBHELPER
  static MainDatabaseHelper _databaseHelper = MainDatabaseHelper._createInstance(); //SINGLETON DBHELPER
  factory MainDatabaseHelper() => _databaseHelper;
  static Database _database;
  
  Future<Database> get database async{
    if(_database==null)
      _database= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //GET THE PATH TO THE DIRECTORY FOR IOS AND ANDROID TO STORE DB
    
    var vsDatabase;
    //OPEN/CREATE THE DB AT A GIVEN PATH
    io.Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path,_dbName);
      vsDatabase =
        await openDatabase(path, version: _dbVersion, onCreate: _createDb, onConfigure: _configureDB);

    // if(kIsWeb){
    //   //Use the database from memory
    //   var databaseFactory = databaseFactoryWeb;
    //   OpenDatabaseOptions openDatabaseOptions=new OpenDatabaseOptions(version: _dbVersion, onCreate: _createDb, onConfigure: _configureDB);
    //   vsDatabase = await databaseFactory.openDatabase(inMemoryDatabasePath,options:openDatabaseOptions);
    // }else{
      
    // }
    
    
    return vsDatabase;
  }


  //Token Table
  String tokenTable='Tokens';
  //String tokenId='TokenId';
  String token='Token';
  String expiryDate='ExpiryDate';
  String tokenType='Type';

  //Topic Table
  String topicTable= 'Topic';
  String topicId = 'TopicId';
  String topicName = 'TopicName';
  String topicType = 'TopicType';
  String topicImage = 'TopicImage';

  //TopicLevelCount
  String countTable='TopicLevelCount';
  String levelCountId='TopicLevelCountId';
  String topicIdFK='TopicId';
  String level='Level';
  String exerciseCount='Count';

  //Task Table
  String topicTaskTable='TopicTask';
  String taskTableId='TopicTaskId';
  String taskType='TaskType';
  //String topicIdFK='TopicId';
  //String level='Level';
  String topicTaskQuestion='TopicTaskQuestion';

  //Subtask Table
  String subtaskTable='TopicSubtasks';
  String subtaskId='TopicSubtaskId';

  //FB Table
  String fbTable='FB';
  String fbId='fbId';
  String paragraph='Paragraph';

  //FBOptions Table;
  String fbOptionsTable='FBOptions';
  String fbOptionId='FBOptionId';
  String fbOption='Option';

  //FBAnswers Table
  String fbAnswersTable='FBAnswers';
  String fbAnswerId='FBAnswerId';
  String fbAnswer='Answer';

  //FBExplanation Table
  String fbExplanationTable='FBExplanations';
  String fbExplanationId='FBExplanationId';
  String fbExplanation='Explanation';
  
  //Jumbled Words Table
  String jwTable='Jumbled_Words';
  String jwId='jwId';
  String jwSentence='Sentence';
  String jwAnswer='Answer';
  String jwExplanation='Explanation';

  void _createDb(Database db, int version) async {

    await db.execute(
      
      '''
      CREATE TABLE $tokenTable(
        $token TEXT PRIMARY KEY,
        $tokenType TEXT,
        $expiryDate STRING
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $topicTable(
        $topicId INTEGER PRIMARY KEY,
        $topicName TEXT UNIQUE, 
        $topicType TEXT, 
        $topicImage TEXT
      )
      '''
    );

    await db.execute(
      
      '''
      CREATE TABLE $countTable(
        $levelCountId INTEGER PRIMARY KEY AUTOINCREMENT,
        $level INTEGER,
        $exerciseCount INTEGER,
        $topicIdFK INTEGER,
        FOREIGN KEY($topicIdFK) REFERENCES $topicTable($topicId)
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $topicTaskTable(
        $taskTableId INTEGER PRIMARY KEY AUTOINCREMENT,
        $taskType TEXT,
        $topicTaskQuestion TEXT,
        $topicIdFK INTEGER,
        FOREIGN KEY($topicIdFK) REFERENCES $topicTable($topicId)
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $subtaskTable(
        $subtaskId INTEGER PRIMARY KEY AUTOINCREMENT,
        $taskTableId INTEGER,
        FOREIGN KEY($taskTableId) REFERENCES $topicTaskTable($taskTableId)
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $fbTable(
        $fbId INTEGER PRIMARY KEY AUTOINCREMENT,
        $paragraph TEXT,
        $subtaskId INTEGER,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $fbOptionsTable(
        $fbOptionId INTEGER PRIMARY KEY AUTOINCREMENT,
        $fbId INTEGER,
        $fbOption TEXT,
        FOREIGN KEY($fbId) REFERENCES $fbId($fbTable)
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $fbAnswersTable(
        $fbAnswerId INTEGER PRIMARY KEY AUTOINCREMENT,
        $fbId INTEGER,
        $fbAnswer TEXT,
        FOREIGN KEY($fbId) REFERENCES $fbId($fbTable)
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $fbExplanationTable(
        $fbExplanationId INTEGER PRIMARY KEY AUTOINCREMENT,
        $fbId INTEGER,
        $fbExplanation TEXT,
        FOREIGN KEY($fbId) REFERENCES $fbId($fbTable)
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE $jwTable(
        $jwId INTEGER PRIMARY KEY,
        $subtaskId INTEGER,
        $jwSentence TEXT,
        $jwAnswer TEXT,
        $jwExplanation TEXT,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      '''
    );
  }

  void _configureDB(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

//   //FETCH TO GET ALL NOTES
//   Future<List<Map<String, dynamic>>> getNoteMapList() async {
//     Database db = await this.database;
//     var result =
//         db.rawQuery("SELECT * FROM $noteTable ORDER BY $colPriority ASC");
// //    var result = await db.query(noteTable, orderBy: "$colPriority ASC");  //WORKS THE SAME CALLED HELPER FUNC
//     return result;
//   }

  /*
  //INSERT OPS
  Future<int> insertNote(Note note) async
  {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //UPDATE OPS
  Future<int> updateNote(Note note) async
  {
    var db = await this.database;
    var result =
    await db.update(noteTable, note.toMap(), where: '$colid = ?', whereArgs: [note.id]);
    return result;
  }

  //DELETE OPS
  Future<int> deleteNote(int id) async
  {
    var db = await this.database;
    int result = await db.delete(noteTable, where:"$colid = ?", whereArgs: [id]);
    return result;
  }

  //GET THE NO:OF NOTES
  Future<int> getCount() async
  {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery("SELECT COUNT (*) FROM $noteTable");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //GET THE 'MAP LIST' [List<Map>] and CONVERT IT TO 'Note List' [List<Note>]
  Future<List<Note>> getNoteList() async
  {
    var noteMapList = await getNoteMapList(); //GET THE MAPLIST FROM DB
    int count = noteMapList.length; //COUNT OF OBJS IN THE LIST
    List<Note> noteList = List<Note>();
    for(int index=0; index<count; index++)
      {
        noteList.add(Note.fromMapObject(noteMapList[index]));
      }
      return noteList;
  }
  */
}