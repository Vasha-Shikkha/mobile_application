import 'task.dart';
import "dart:async";
import "dart:io";
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



class PWList{
  List<PW> _pwList;
  
  List<PW> get pwList => this._pwList;

  set pwList(List<PW> value) => this._pwList = value;

  PWList({
    List<PW>pwList
  }):_pwList= pwList;

  factory PWList.fromJson(List<dynamic> json){
    
    List<PW>pwList = [];
    for(dynamic element in json)
    {
      Map<String,dynamic>taskDetail=element['taskDetail'];
      List< dynamic >questions=element['questions']; 

      for(Map<String,dynamic>question in questions)
      {
        PW pw=new PW.fromJson(taskDetail,question);
        pwList.add(pw);
      }
    }

    // print(pwList.length);

    return new PWList(pwList:pwList);
  }

}


class PW extends SubTask{
  int _id;
  String _question;
  String _image; // Has two getters. One is chunks, the other is answer
  String _answer;
  List<String> _options;
  String _explanation;
  
  get id => this._id;

  set id( value) => this._id = value;

  get image => this._image;

  set image( value) => this._image = value;

  get question => this._question;

  set question( value) => this._question = value;

  get answer => this._answer;

  set answer( value) => this._answer = value;

  get options => this._options;

  set options( value) => this._options = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  PW({
    int id,
    int subtaskId,
    int taskId,
    int level,
    int topicId,
    String taskName,
    String instruction,
    String instructionImage,
    String question,
    String answer,
    String explanation,
    String image,
    List<String> options
  }): _id=id,
      _explanation=explanation,
      _image=image,
      _options = options,
      super(
        taskId: taskId,
        subtaskId: subtaskId,
        level: level,
        topicId: topicId,
        taskName: taskName,
        instruction: instruction,
        instructionImage: instructionImage
      );

  factory PW.fromJson(Map<String,dynamic> taskDetail,Map<String,dynamic>question)
  {  
    
    return new PW(
      id : question['id'],
      question : question['paragraph'],
      image : question['image'],
      options: question['options'],
      answer : question['answer'],
      explanation: question['explanation'],
      taskId : taskDetail['id'],
      topicId: taskDetail['topic_id'],
      subtaskId: question['subTask_id'],
      level: taskDetail['level'],
      taskName: taskDetail['name'],
      instruction: taskDetail['instruction'],
      instructionImage: taskDetail['instructionImage']

    );
  }

  Future<String>downloadImage(String url)async
  {
    Dio dio= Dio(); 
    Directory directory = await getApplicationDocumentsDirectory();
    String savePath="pw_"+id.toString()+"_image";
    var res= await dio.download(url, savePath);
    if(res.statusCode == 200)
      return savePath;
    
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

  Map<String,dynamic>toPW()
  { 
    Map<String,dynamic>map= new Map();
    map['pwId']=id;
    map['Image'] = image;
    map['Question']=question;
    map['Options']=concatenateElements(options);
    map['Answer']=answer;
    map['Explanation']=explanation;
    map['SubtaskId']=subtaskId;
  
    return map;
  }

  factory PW.fromDatabase(Map<String,dynamic>taskDetails,Map<String,dynamic>questions)
  {   
    
    List<String>optionList=[];
    if(questions['Options']!=null)
      optionList=questions['Options'].split('#');

    return new PW(
      id : questions['pwId'],
      question : questions['Question'],
      answer : questions['Answer'],
      image : questions['Image'],
      options: optionList,
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

}