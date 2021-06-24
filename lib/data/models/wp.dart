import 'task.dart';
import "dart:async";
import "dart:io";
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class WPList{
  List<WP> _wpList;
  
  List<WP> get wpList => this._wpList;

  set wpList(List<WP> value) => this._wpList = value;

  WPList({
    List<WP>wpList
  }):_wpList= wpList;

  factory WPList.fromJson(List<dynamic> json){
    
    List<WP>wpList = [];
    for(dynamic element in json)
    {
      Map<String,dynamic>taskDetail=element['taskDetail'];
      List< dynamic >questions=element['questions']; 

      for(Map<String,dynamic>question in questions)
      {
        WP wp=new WP.fromJson(taskDetail,question);
        wpList.add(wp);
      }
    }

    // print(pwList.length);

    return new WPList(wpList:wpList);
  }

}


class WP extends SubTask{
  int _id;
  String _question;
  List<String> _images; // Has two getters. One is chunks, the other is answer
  String _answer;
  String _explanation;
  
  get id => this._id;

  set id( value) => this._id = value;

  get images => this._images;

  set images( value) => this._images = value;

  get question => this._question;

  set question( value) => this._question = value;

  get answer => this._answer;

  set answer( value) => this._answer = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  WP({
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
    List<String> images,
  }): _id=id,
      _explanation=explanation,
      _images=images,
      super(
        taskId: taskId,
        subtaskId: subtaskId,
        level: level,
        topicId: topicId,
        taskName: taskName,
        instruction: instruction,
        instructionImage: instructionImage
      );

  factory WP.fromJson(Map<String,dynamic> taskDetail,Map<String,dynamic>question)
  { 

    //Map<String,dynamic>taskDetails= json['taskDetail'];
    //List<Map<String,dynamic> >questions 
    
    return new WP(
      id : question['id'],
      question : question['question'],
      images : question['images'],
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

  Future<List<String>> downloadImages()async
  { 
    Dio dio= Dio(); 
    Directory directory = await getApplicationDocumentsDirectory();
    List<String>pathList=[];
    int imgNum=1;
    
    String answerImg=answer;
    for(String url in images)
    {
      String savePath="wp_"+id.toString()+"_image"+imgNum.toString();
      var res= await dio.download(url, savePath);
      if(res.statusCode == 200)
      {
        pathList.add(savePath);
        if(url == answer)
          answerImg=savePath;
      }
        
    }
    
    answer=answerImg;
    return pathList;
    
  }

  String concatenateElements(List<String>strings)
  {
    String result="";
    for(String chunk in strings)
      result=result+" "+chunk;
    return result.trim();
  }

  List<String> tokenizeElements(String string)
  {
    List<String>tokens=string.split(" ");
    return tokens;
  }

  Map<String,dynamic>toWP()
  { 
    Map<String,dynamic>map= new Map();
    map['wpId']=id;
    map['Images'] = concatenateElements(images);
    map['Question']=question;
    map['Answer']=answer;
    map['Explanation']=explanation;
    map['SubtaskId']=subtaskId;
  
    return map;
  }

  factory WP.fromDatabase(Map<String,dynamic>taskDetails,Map<String,dynamic>questions)
  {   
    List<String>tokens=questions['Images'].split(" ");
    

    return new WP(
      id : questions['wpId'],
      question : questions['Question'],
      answer : questions['Answer'],
      images : tokens,
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