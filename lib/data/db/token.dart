import 'dart:async';
import 'dart:io' as io;

import 'main.dart';
import 'package:path/path.dart';
import '../models/topic.dart';
import '../models/token.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class TokenDatabaseHelper{
  
  TokenDatabaseHelper._createInstance();
  static final TokenDatabaseHelper _instance = new TokenDatabaseHelper._createInstance();

  factory TokenDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();

  String _tokenTable='Tokens';
  //String tokenId='TokenId';
  String _token='Token';
  String _expiryDate='ExpiryDate';
  String _tokenType='Type';

  Future<Token>getToken() async{
    var database = await _databaseHelper.database;

    List<Map<String,dynamic> >results= await database.query(_tokenTable,
                                      columns: [_token,_tokenType,_expiryDate],
                                      limit:1);
    
    
    //There will be only 1 entry anyway
    Map<String,dynamic>result=results[0];

    return Token.fromDatabase(result);            
  }

  Future<int> getCount() async{
    var database = await _databaseHelper.database;
    List<Map<String,dynamic>> x = await database.rawQuery('SELECT COUNT(*) FROM $_tokenTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int>insertToken(Map<String,dynamic>token)async{
    var database= await _databaseHelper.database;
    return await database.insert(_tokenTable,token,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int>deleteToken()async{
    var database= await _databaseHelper.database;
    return await database.delete(_tokenTable);
  }
  
}