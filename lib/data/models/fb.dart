//import 'dart:core';
import 'task.dart';
//import 'subtask.dart';

class FBList{
  List<FB> _fbs;
  
  List<FB> get fbs => this._fbs;

  set fbs(List<FB> value) => this._fbs = value;

  FBList({
    List<FB>fbs
  }):_fbs= fbs;

  factory FBList.fromJson(List<dynamic> json){
    
    List<FB>fbs = [];

    for(dynamic element in json)
    {
      Map<String,dynamic>taskDetail=element['taskDetail'];
      List< Map<String,dynamic> >questions=element['questions'];

      for(Map<String,dynamic>question in questions)
      {
        FB fb=new FB.fromJson(taskDetail,question);
        fbs.add(fb);
      }
    }

    //fbs = json.map((i)=>FB.fromJson((i))).toList();
    return new FBList(fbs:fbs);
  }

}

class FB extends SubTask{
  int _fbId;
  String _paragraph;
  List<FBOptions>_options;
  List<FBAnswers>_answers;
  List<FBExplanations>_explanation;
  
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
    int subtaskId,
    int taskId,
    int level,
    int topicId,
    String taskName,
    String instruction,
    String instructionImage,
    String paragraph,
    List<FBOptions> options,
    List<FBAnswers> answers,
    List<FBExplanations> explanation
  }): _fbId=id,
      _paragraph=paragraph,
      _answers=answers,
      _explanation=explanation,
      super(
        taskId: taskId,
        subtaskId: subtaskId,
        level: level,
        topicId: topicId,
        taskName: taskName,
        instruction: instruction,
        instructionImage: instructionImage
      );

  factory FB.fromJson(Map<String,dynamic> taskDetail,Map<String,dynamic>question)
  { 

    //Map<String,dynamic>taskDetails= json['taskDetail'];
    //List<Map<String,dynamic> >questions =

    List<FBOptions>fbOptions=[];
    List<FBAnswers>fbAnswers=[];
    List<FBExplanations>fbExplanations=[];

    fbOptions = question['options'].map((i)=>FBOptions.fromJson((i))).toList();
    fbAnswers = question['answers'].map((i)=>FBAnswers.fromJson((i))).toList();
    fbExplanations = question['explanation'].map((i)=>FBExplanations.fromJson((i))).toList();
    

    return new FB(
      paragraph : question['paragraph'],
      options : fbOptions,
      answers : fbAnswers,
      explanation : fbExplanations,
      taskId : taskDetail['id'],
      subtaskId: question['subTask_id'],
      level: question['level'],
      taskName: question['name'],
      instruction: question['instruction'],
      instructionImage: question['instructionImage']

    );
  }

}

class FBOptions{
  int _fbOptionsId;
  int _fbId;
  String _option;

  int get fbOptionsId => this._fbOptionsId;

  set fbOptionsId(int value) => this._fbOptionsId = value;

  int get fbId => this._fbId;

  set fbId(int value) => this._fbId = value;

  get option => this._option;

  set option( value) => this._option = value;

  FBOptions({
    int fbOptionsId,
    int fbId,
    String option
  }):_fbOptionsId = fbOptionsId,
    _fbId = fbId,
    _option=option;

  factory FBOptions.fromJson(String option)
  {
    return new FBOptions
    (
      option:option
    );
  }
}

class FBExplanations{
  int _fbExplanationsId;
  int _fbId;
  String _explanation;

  int get fbExplanationsId => this._fbExplanationsId;

  set fbExplanationsId(int value) => this._fbExplanationsId = value;

  int get fbId => this._fbId;

  set fbId(int value) => this._fbId = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  FBExplanations({
    int fbExplanationsId,
    int fbId,
    String explanation
  }):_fbExplanationsId = fbExplanationsId,
    _fbId = fbId,
    _explanation=explanation;

  factory FBExplanations.fromJson(String explanation)
  {
    return new FBExplanations
    (
      explanation:explanation
    );
  }
}

class FBAnswers{
  int _fbAnswersId;
  int _fbId;
  String _answer;

  int get fbAnswersId => this._fbAnswersId;

  set fbAnswersId(int value) => this._fbAnswersId = value;

  int get fbId => this._fbId;

  set fbId(int value) => this._fbId = value;

  get answer => this._answer;

  set answer( value) => this._answer = value;

  FBAnswers({
    int fbAnswersId,
    int fbId,
    String answer
  }):_fbAnswersId = fbAnswersId,
    _fbId = fbId,
    _answer=answer;

  factory FBAnswers.fromJson(String answer)
  {
    return new FBAnswers
    (
      answer:answer
    );
  }
}