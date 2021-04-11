//import 'dart:core';

import 'subtask.dart';

class FB extends SubTask{
  int _fbId;
  String _paragraph;
  List<String>_options;
  List<String>_answers;
  List<String>_explanation;
  
  int get fbId => this._fbId;

  set fbId(int value) => this._fbId = value;

  get paragraph => this._paragraph;

  set paragraph( value) => this._paragraph = value;

  get options => this._options;

  set options( value) => this._options = value;

  get answers => this._answers;

  set answers( value) => this._answers = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  FB({
    int id,
    String paragraph,
    List<String> options,
    List<String> answers,
    List<String> explanation
  }): _fbId=id,
      _paragraph=paragraph,
      _answers=answers,
      _explanation=explanation;

  factory FB.fromJson(Map<String,dynamic> json)
  {
    return new FB(
      paragraph : json['paragraph'],
      options : json['options'],
      answers : json['answers'],
      explanation : json['explanation']
    );
  }

}