import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/dict.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DictDatabaseHelper{

  DictDatabaseHelper._createInstance();
  static final DictDatabaseHelper _instance = new DictDatabaseHelper._createInstance();

  factory DictDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();
  
  String _dictTable='Dictionary';
  String _dictWord='Word';
  String _dictMeaning='Meaning';
  String _dictExamples='Examples';

  String _flashCardTable='FlashCard';
  String _flashCardId='Id';
  String _timestamp='Timestamp';


  Future<List<String> >getWordList()async
  { 
    var database=await _databaseHelper.database;
    List<Map<String,dynamic> >dictEntries=await database.query(_dictTable,columns:[_dictWord]);
    List<String>words=[];
    for(Map<String,dynamic>entry in dictEntries)
      words.add(entry[_dictWord]);
  
    return words;
  }

  Future<int>getCount()async{
    var database= await _databaseHelper.database;
    List<Map<String,dynamic>> x = await database.rawQuery('SELECT COUNT(*) FROM $_dictTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int>insertDictEntry(DictEntry entry)async{
    var database= await _databaseHelper.database;
    return await database.insert(_dictTable, entry.toDict(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<DictEntry>getEntry(String word)async{
    var database= await _databaseHelper.database;
    List<Map<String,dynamic>>dictEntries= await database.query(_dictTable,columns:[_dictWord,_dictMeaning,_dictExamples],
                                                              where:'$_dictWord=?',
                                                              whereArgs: [word]);
    // print(dictEntries.length);
    // print(dictEntries[0]);
    DictEntry entry=new DictEntry.fromDatabase(dictEntries[0]);
    //print("Hello");
    return entry;
  }

  Future<int>insertFlashCardEntry(String word)async
  { 
    var database = await _databaseHelper.database;
    Map<String,dynamic>map=new Map();
    map[_dictWord]=word;
    map[_timestamp]=DateTime.now().toIso8601String();
  
    return await database.insert(_flashCardTable,map,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DictEntry>>getFlashCards()async
  {
    var database = await _databaseHelper.database;
    List<Map<String,dynamic> >dictEntries = await database.query('''
                                                                  $_dictTable INNER JOIN $_flashCardTable ON
                                                                  $_dictTable.$_dictWord = $_flashCardTable.$_dictWord
                                                                '''
                                                                ,columns: ['$_dictTable.$_dictWord',_dictMeaning,_dictExamples],
                                                                orderBy: '$_timestamp DESC');

    List<DictEntry>entries=[];
  
    for(Map<String,dynamic>entry in dictEntries)
      entries.add(new DictEntry.fromDatabase(entry));
  
    return entries;
  }

}
