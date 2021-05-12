import 'task.dart';

//import 'dart:core';
import 'task.dart';
//import 'subtask.dart';

class MCQList{
  List<MCQ> _mcqList;
  
  List<MCQ> get mcqList => this._mcqList;

  set mcqList(List<MCQ> value) => this._mcqList = value;

  MCQList({
    List<MCQ>mcqList
  }):_mcqList= mcqList;

  factory MCQList.fromJson(List<dynamic> json){
    
    List<MCQ>mcqList = [];

    for(dynamic element in json)
    {
      Map<String,dynamic>taskDetail=element['taskDetail'];
      List<dynamic>questions=element['questions'];

      for(Map<String,dynamic>question in questions)
      {
        MCQ mcq=new MCQ.fromJson(taskDetail,question);
        mcqList.add(mcq);
      }
    }

    //fbs = json.map((i)=>FB.fromJson((i))).toList();
    return new MCQList(mcqList:mcqList);
  }

}

class MCQ extends SubTask{
  int _mcqId;
  String _question;
  List<String>_options;
  String _answer;
  String _explanation;
  
  int get mcqId => this._mcqId;

  set mcqId(int value) => this._mcqId = value;

  get question => this._question;

  set question( value) => this._question = value;

  get options => this._options;

  set options( value) => this._options = value;

  get answer => this._answer;

  set answer( value) => this._answer = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  MCQ({
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
    String explanation
  }): _mcqId=id,
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

  factory MCQ.fromJson(Map<String,dynamic> taskDetail,Map<String,dynamic>question)
  { 

    //Map<String,dynamic>taskDetails= json['taskDetail'];
    //List<Map<String,dynamic> >questions =

    List<String>mcqOptions=[];
    
    if(question['options']!=null)
    { 
      print("In options");
      for(String option in question['options'])
      { 
        //print(option);
        mcqOptions.add(option);
      }
        
    }
    
    // fbOptions = question['options'].map((i)=>FBOptions.fromJson((i))).toList();
    // fbAnswers = question['answers'].map((i)=>FBAnswers.fromJson((i))).toList();
    // fbExplanations = question['explanation'].map((i)=>FBExplanations.fromJson((i))).toList();
    

    return new MCQ(
      id: question['id'],
      question : question['question'],
      options : mcqOptions,
      answer : question['answer'],
      explanation : question['explanation'],
      taskId : taskDetail['id'],
      subtaskId: question['subTask_id'],
      level: taskDetail['level'],
      topicId: taskDetail['topic_id'],
      taskName: taskDetail['name'],
      instruction: taskDetail['instruction'],
      instructionImage: taskDetail['instructionImage']

    );
  }

  Map<String,dynamic>toMCQ()
  {
    Map<String,dynamic>map= new Map();
    
    map['mcqId']=mcqId;
    map['SubtaskId']=subtaskId;
    map['Options']=concatenateElements(options);
    map['Answer']=answer;
    map['Explanation']=explanation;
    map['Question']=question;

    return map;
  }

  factory MCQ.fromDatabase(Map<String,dynamic>taskDetails,Map<String,dynamic>questions)
  {   

    List<String>optionList=[];
    
    if(questions['Options']!=null)
    { 
      
      optionList=questions['Options'].split('#');
      print(optionList);
    }
      

    return new MCQ(
      id: questions['mcqId'],
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
    print("MCQId: "+mcqId.toString());
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

