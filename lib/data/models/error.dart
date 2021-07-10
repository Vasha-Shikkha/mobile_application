import 'task.dart';

//import 'dart:core';
import 'task.dart';
//import 'subtask.dart';

class ErrorList extends TaskList{
  List<Error> _errorList;
  
  List<Error> get errorList => this._errorList;

  set errorList(List<Error> value) => this._errorList = value;

  ErrorList({
    List<Error>errorList
  }):_errorList= errorList;

  factory ErrorList.fromJson(List<dynamic> json){
    
    List<Error>errorList = [];

    for(dynamic element in json)
    {
      Map<String,dynamic>taskDetail=element['taskDetail'];
      List<dynamic>questions=element['questions'];

      for(Map<String,dynamic>question in questions)
      {
        Error error=new Error.fromJson(taskDetail,question);
        errorList.add(error);
      }
    }

    //fbs = json.map((i)=>FB.fromJson((i))).toList();
    return new ErrorList(errorList:errorList);
  }

}

class Error extends SubTask{
  int _errorId;
  String _question;
  List<String>_options;
  String _answer;
  String _explanation;
  

  int get errorId => this._errorId;

  set errorId(int value) => this._errorId = value;

  get question => this._question;

  set question( value) => this._question = value;

  get options => this._options;

  set options( value) => this._options = value;

  get answer => this._answer;

  set answer( value) => this._answer = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;


  Error({
    int id,
    int subtaskId,
    int taskId,
    int level,
    int topicId,
    String taskName,
    String instruction,
    String instructionImage,
    String question,
    List<String> options,
    String answer,
    String explanation,
  }): _errorId=id,
      _options=options,
      _question=question,
      _answer=answer,
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

  factory Error.fromJson(Map<String,dynamic> taskDetail,Map<String,dynamic>question)
  { 

    //Map<String,dynamic>taskDetails= json['taskDetail'];
    //List<Map<String,dynamic> >questions =

    List<String>errorOptions=[];
    
    if(question['options']!=null)
    { 
      print("In options");
      for(String option in question['options'])
      { 
        //print(option);
        errorOptions.add(option);
      }
        
    }
    
    // fbOptions = question['options'].map((i)=>FBOptions.fromJson((i))).toList();
    // fbAnswers = question['answers'].map((i)=>FBAnswers.fromJson((i))).toList();
    // fbExplanations = question['explanation'].map((i)=>FBExplanations.fromJson((i))).toList();
    

    return new Error(
      id: question['id'],
      question : question['question'],
      options : errorOptions,
      answer : question['answer'],
      explanation : question['explanation'],
      taskId : taskDetail['task_id'],
      subtaskId: question['subTaskId'],
      level: taskDetail['level'],
      topicId: taskDetail['topic_id'],
      taskName: taskDetail['name'],
      instruction: taskDetail['instruction'],
      instructionImage: taskDetail['instructionImage']

    );
  }

  Map<String,dynamic>toError()
  {
    Map<String,dynamic>map= new Map();
    
    // int flag = (isMCQ)? 1 : 0;

    if(errorId!=null)
      map['errorId']=errorId;
    map['SubtaskId']=subtaskId;
    map['Options']=concatenateElements(options);
    map['Answer']=answer;
    map['Explanation']=explanation;
    map['Question']=question;
    

    return map;
  }

  factory Error.fromDatabase(Map<String,dynamic>taskDetails,Map<String,dynamic>questions)
  {   

    List<String>optionList=[];
    
    if(questions['Options']!=null)
    { 
      
      optionList=questions['Options'].split('#');
      print(optionList);
    }

    bool flag=true;    
    if(questions['isMCQ']==1)
      flag=true;
    else
      flag=false;

    return new Error(
      id: questions['errorId'],
      question : questions['Question'],
      options : optionList,
      answer : questions['Answer'],
      explanation : questions['Explanation'],
      taskId : taskDetails['TopicTaskId'],
      subtaskId: questions['SubtaskId'],
      level: taskDetails['Level'],
      topicId: taskDetails['TopicId'],
      taskName: taskDetails['TaskType'],
      instruction: taskDetails['Instruction'],
      instructionImage: taskDetails['Instruction_Image']
    );

  }
  
  String concatenateElements(List<String>list)
  { 
    if(list.isEmpty)
      return null;

    String result="";
    for(String element in list)
      result=result+element+"#";
    result=result.substring(0,result.length-1);
    return result;
    
  }

  void debugMessage()
  {
    print("Task_Id: "+taskId.toString());
    print("Level: "+level.toString());
    print("Taskname: "+taskName);
    print("TopicId: "+topicId.toString());
    print("SubtaskId: "+subtaskId.toString());
    print("ErrorId: "+errorId.toString());
    print("Question: "+question);
    print("Options: "+options.toString());
    print("Answer: "+answer.toString());
    //print("Explanation: ");
    //String taskName,
    //int topicId,
    //String instruction,
    //String instructionImage
  }
}

