import 'task.dart';

class JSList{
  List<JS> _jsList;
  
  List<JS> get jsList => this._jsList;

  set jsList(List<JS> value) => this._jsList = value;

  JSList({
    List<JS>jsList
  }):_jsList= jsList;

  factory JSList.fromJson(List<dynamic> json){
    
    List<JS>jsList = [];

    for(dynamic element in json)
    {
      Map<String,dynamic>taskDetail=element['taskDetail'];
      List< Map<String,dynamic> >questions=element['questions'];

      for(Map<String,dynamic>question in questions)
      {
        JS js=new JS.fromJson(taskDetail,question);
        jsList.add(js);
      }
    }

    //fbs = json.map((i)=>FB.fromJson((i))).toList();
    return new JSList(jsList:jsList);
  }

}


class JS extends SubTask{
  int _id;
  String _sentence;
  List<String> _chunks;
  String _explanation;
  
  get id => this._id;

  set id( value) => this._id = value;

  get sentence => this._sentence;

  set sentence( value) => this._sentence = value;

  get chunks{
    List<String>value = new List<String>();
    for(String chunk in _chunks)
      value.add(chunk);
    value.shuffle();
    return value;
  }

  set chunks( value) => this._chunks = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  JS({
    int id,
    int subtaskId,
    int taskId,
    int level,
    int topicId,
    String taskName,
    String instruction,
    String instructionImage,
    String sentence,
    List<String> chunks,
    String explanation
  }): _id=id,
      _explanation=explanation,
      _chunks=chunks,
      _sentence=sentence,
      super(
        taskId: taskId,
        subtaskId: subtaskId,
        level: level,
        topicId: topicId,
        taskName: taskName,
        instruction: instruction,
        instructionImage: instructionImage
      );

  factory JS.fromJson(Map<String,dynamic> taskDetail,Map<String,dynamic>question)
  { 

    //Map<String,dynamic>taskDetails= json['taskDetail'];
    //List<Map<String,dynamic> >questions 
    return JS(
      sentence : question['paragraph'],
      chunks : question['chunks'],
      explanation : question['explanation'],
      taskId : taskDetail['id'],
      subtaskId: question['subTask_id'],
      level: question['level'],
      taskName: question['name'],
      instruction: question['instruction'],
      instructionImage: question['instructionImage']

    );
  }

  String concatenateChunks(List<String>tokens)
  {
    String result="";
    for(String chunk in tokens)
      result=result+" "+chunk;
    return result.trim();
  }

  List<String> tokenizeChunk(String sentence)
  {
    List<String>tokens=sentence.split(" ");
    return tokens;
  }


}