import 'package:Vasha_Shikkha/data/models/task.dart';

class JWList{
  List<JW> _tasks;
  
  List<JW> get tasks => this._tasks;

  set tasks(List<JW> value) => this._tasks = value;

  JWList({
    List<JW>tasks
  }):_tasks= tasks;

  factory JWList.fromJson(List<dynamic> json,int level,int topicId){
    List<JW>tasks = [];
    tasks = json.map((i)=>JW.fromJson((i),level,topicId)).toList();
    return new JWList(tasks:tasks);
  }

  factory JWList.fromDatabase(List<dynamic>maps){
    List<JW>tasks = [];
    tasks=maps.map((i)=>JW.fromDatabase(i)).toList();
    return new JWList(tasks:tasks);
  }
}


class JW extends SubTask{
  int _id;
  //int _subtaskId;
  String _sentence;
  String _answer;
  String _explanation;
 
  int get id => this._id;

  set id(int value) => this._id = value;

  //get subtaskId => this._subtaskId;

  //set subtaskId( value) => this._subtaskId = value;

  get sentence => this._sentence;

  set sentence( value) => this._sentence = value;

  get answer => this._answer;

  set answer( value) => this._answer = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  JW({
    int id,
    int level,
    int topicId,
    int subtaskId,
    String sentence,
    String answer,
    String explanation,
  }):_id =id,
    _sentence=sentence,
    _answer=answer,
    _explanation=explanation,
    super(subtaskId:subtaskId,
          level:level,
          topicId:topicId,
          taskName:'Jumbled_Word'
          );

  factory JW.fromJson(Map<String,dynamic>json,int level,int topicId)
  {
    return new JW(
      id: json['id'],
      subtaskId: json['subTask_id'],
      sentence: json['paragraph'],
      answer: json['answer'],
      explanation: json['explanation'],
      level:level,
      topicId: topicId
    );
  }

  Map<String,dynamic>toDatabase()
  {
    Map<String,dynamic>result = new Map();
    result['jwId']=id;
    result['subtaskId']=subtaskId;
    result['Sentence']=sentence;
    result['Answer']=answer;
    result['Explanation']=explanation;

    return result;
  }

  factory JW.fromDatabase(Map<String,dynamic>map)
  {
    return new JW(
      id : map['jwId'],
      subtaskId: map['subtaskId'],
      sentence: map['Sentence'],
      answer: map['Answer'],
      explanation: map['Explanation']
    );
  }

  List<String>jumbedAnswer()
  {
    List<String>result=answer.split('');
    return result;
  }


}