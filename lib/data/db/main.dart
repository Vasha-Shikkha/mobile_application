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
  static final _dbName = 'vs.db';
  static final _dbVersion = 1;

  MainDatabaseHelper._createInstance(); //NAMED CONST TO CREATE INSTANCE OF THE DBHELPER
  static MainDatabaseHelper _databaseHelper =
      MainDatabaseHelper._createInstance(); //SINGLETON DBHELPER
  factory MainDatabaseHelper() => _databaseHelper;
  static Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //GET THE PATH TO THE DIRECTORY FOR IOS AND ANDROID TO STORE DB

    var vsDatabase;
    //OPEN/CREATE THE DB AT A GIVEN PATH
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    vsDatabase = await openDatabase(path,
        version: _dbVersion, onCreate: _createDb, onConfigure: _configureDB);

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
  String tokenTable = 'Tokens';
  //String tokenId='TokenId';
  String token = 'Token';
  String expiryDate = 'ExpiryDate';
  String tokenType = 'Type';

  //Topic Table
  String topicTable = 'Topic';
  String topicId = 'TopicId';
  String topicName = 'TopicName';
  String topicType = 'TopicType';
  String topicImage = 'TopicImage';

  //TopicLevelCount
  String countTable = 'TopicLevelCount';
  String levelCountId = 'TopicLevelCountId';
  String topicIdFK = 'TopicId';
  String level = 'Level';
  String exerciseCount = 'Count';

  //Task Table
  String topicTaskTable = 'TopicTask';
  String taskTableId = 'TopicTaskId';
  String taskType = 'TaskType';
  //String topicIdFK='TopicId';
  String taskLevel = 'Level';
  String taskInstruction = 'Instruction';
  String taskInstructionImage = 'Instruction_Image';
  String taskExerciseInstructions = 'ExerciseInstructions';

  //Subtask Table
  String subtaskTable = 'Subtasks';
  String subtaskId = 'SubtaskId';

  //FB Table
  String fbTable = 'FB';
  String fbId = 'fbId';
  String paragraph = 'Paragraph';
  String options = 'Options';
  String answers = 'Answers';
  String explanations = 'Explanations';

  //Jumbled Words Table
  String jwTable = 'Jumbled_Words';
  String jwId = 'jwId';
  String jwSentence = 'Sentence';
  String jwAnswer = 'Answer';
  String jwExplanation = 'Explanation';

  //Jumbled Sentence Table
  String jsTable = 'Jumbled_Sentence';
  String jsId = 'jsId';
  String jsSentence = 'Sentence';
  String jsAnswer = 'Answer';
  String jsExplanation = 'Explanation';

  //MCQ Table
  String mcqTable = 'MCQ';
  String mcqId = 'mcqId';
  String mcqQuestion = 'Question';
  String mcqOptions = 'Options';
  String mcqAnswer = 'Answer';
  String mcqExplanation = 'Explanation';

  //Error Table
  String errorTable = 'Error_In_Sentence';
  String errorId = 'errorId';
  String errorQuestion = 'Question';
  String errorOptions = 'Options';
  String errorAnswer = 'Answer';
  String errorExplanation = 'Explanation';

  //WP Table
  String wpTable = 'Word_to_Picture';
  String wpId = 'wpId';
  String wpQuestion = 'Question';
  String wpImages = 'Images';
  String wpAnswer = 'Answer';
  String wpExplanation = 'Explanation';

  //PW Table
  String pwTable = 'Picture_to_Word';
  String pwId = 'pwId';
  String pwQuestion = 'Question';
  String pwOptions = 'Options';
  String pwImage = 'Image';
  String pwAnswer = 'Answer';
  String pwExplanation = 'Explanation';

  //SM Table
  String smTable = 'Sentence_Matching';
  String smId = 'smId';
  String smPartOne = 'PartOne';
  String smPartTwo = 'PartTwo';
  String smExplanation = 'Explanation';

  //Dict Table
  String dictTable = 'Dictionary';
  String dictWord = 'Word';
  String dictMeaning = 'Meaning';
  String dictExamples = 'Examples';

  //FlashCard
  String flashCardTable = 'FlashCard';
  String flashCardId = 'Id';
  String timestamp = 'Timestamp';

  void _createDb(Database db, int version) async {
    //Token Table
    await db.execute('''
      CREATE TABLE $tokenTable(
        $token TEXT PRIMARY KEY,
        $tokenType TEXT,
        $expiryDate STRING
      )
      ''');

    //Topic Table
    await db.execute('''
      CREATE TABLE $topicTable(
        $topicId INTEGER PRIMARY KEY,
        $topicName TEXT UNIQUE, 
        $topicType TEXT, 
        $topicImage TEXT
      )
      ''');

    //Count Table
    await db.execute('''
      CREATE TABLE $countTable(
        $levelCountId INTEGER PRIMARY KEY AUTOINCREMENT,
        $level INTEGER,
        $exerciseCount INTEGER,
        $topicIdFK INTEGER,
        FOREIGN KEY($topicIdFK) REFERENCES $topicTable($topicId)
      )
      ''');

    //Topic Task
    await db.execute('''
      CREATE TABLE $topicTaskTable(
        $taskTableId INTEGER PRIMARY KEY,
        $taskLevel INTEGER,
        $taskType TEXT,
        $taskInstruction TEXT,
        $taskExerciseInstructions TEXT,
        $taskInstructionImage TEXT,
        $topicIdFK INTEGER,
        FOREIGN KEY($topicIdFK) REFERENCES $topicTable($topicId)
      )
      ''');

    //Subtask Table
    await db.execute('''
      CREATE TABLE $subtaskTable(
        $subtaskId INTEGER PRIMARY KEY,
        $taskTableId INTEGER,
        FOREIGN KEY($taskTableId) REFERENCES $topicTaskTable($taskTableId)
      )
      ''');

    //FB Table
    await db.execute('''
      CREATE TABLE $fbTable(
        $fbId INTEGER PRIMARY KEY AUTOINCREMENT,
        $paragraph TEXT,
        $options TEXT,
        $answers TEXT,
        $explanations TEXT,
        $subtaskId INTEGER,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //Jumbled Words Table
    await db.execute('''
      CREATE TABLE $jwTable(
        $jwId INTEGER PRIMARY KEY,
        $subtaskId INTEGER,
        $jwSentence TEXT,
        $jwAnswer TEXT,
        $jwExplanation TEXT,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //Jumbled Sentence Table
    await db.execute('''
      CREATE TABLE $jsTable(
        $jsId INTEGER PRIMARY KEY AUTOINCREMENT,
        $subtaskId INTEGER,
        $jsSentence TEXT,
        $jsAnswer TEXT,
        $jsExplanation TEXT,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //MCQ Table
    await db.execute('''
      CREATE TABLE $mcqTable(
        $mcqId INTEGER PRIMARY KEY,
        $mcqQuestion TEXT,
        $mcqOptions TEXT,
        $mcqAnswer TEXT,
        $mcqExplanation TEXT,
        $subtaskId INTEGER,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //Error in Sentence Table
    await db.execute('''
      CREATE TABLE $errorTable(
        $errorId INTEGER PRIMARY KEY,
        $errorQuestion TEXT,
        $errorOptions TEXT,
        $errorAnswer TEXT,
        $errorExplanation TEXT,
        $subtaskId INTEGER,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //Word to Picture Table
    await db.execute('''
      CREATE TABLE $wpTable(
        $wpId INTEGER PRIMARY KEY,
        $wpQuestion TEXT,
        $wpImages TEXT,
        $wpAnswer TEXT,
        $wpExplanation TEXT,
        $subtaskId INTEGER,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //Picture to Word Table
    await db.execute('''
      CREATE TABLE $pwTable(
        $pwId INTEGER PRIMARY KEY AUTOINCREMENT,
        $pwQuestion TEXT,
        $pwImage TEXT,
        $pwAnswer TEXT,
        $pwOptions TEXT,
        $pwExplanation TEXT,
        $subtaskId INTEGER,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //Sentence Matching
    await db.execute('''
      CREATE TABLE $smTable(
        $smId INTEGER PRIMARY KEY AUTOINCREMENT,
        $smPartOne TEXT,
        $smPartTwo TEXT,
        $smExplanation TEXT,
        $subtaskId INTEGER,
        FOREIGN KEY($subtaskId) REFERENCES $subtaskTable($subtaskId)
      )
      ''');

    //Dict Table
    await db.execute('''
      CREATE TABLE $dictTable(
        $dictWord TEXT PRIMARY KEY,
        $dictMeaning TEXT,
        $dictExamples TEXT
      )
      ''');

    //FlashCard Table
    await db.execute('''
      CREATE TABLE $flashCardTable(
        $flashCardId INTEGER PRIMARY KEY AUTOINCREMENT,
        $dictWord TEXT UNIQUE,
        $timestamp TEXT,
        FOREIGN KEY($dictWord) REFERENCES $dictTable($dictWord)
      )  
      ''');
  }

  void _configureDB(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }
}
