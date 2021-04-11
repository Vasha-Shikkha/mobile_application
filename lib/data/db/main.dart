import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);

    //OPEN/CREATE THE DB AT A GIVEN PATH
    var vsDatabase =
        await openDatabase(path, version: _dbVersion, onCreate: _createDb, onConfigure: _configureDB);
    return vsDatabase;
  }

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

  void _createDb(Database db, int version) async {

    await db.execute(
      '''
      CREATE TABLE $topicTable(
        $topicId INTEGER PRIMARY KEY AUTOINCREMENT,
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
        FOREIGN KEY($topicIdFK) REFRENCES $topicTable($topicId)
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