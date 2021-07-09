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
      List< dynamic >questions=element['questions']; 

      for(Map<String,dynamic>question in questions)
      {
        JS js=new JS.fromJson(taskDetail,question);
        jsList.add(js);
      }
    }

    print(jsList.length);

    return new JSList(jsList:jsList);
  }

}


class JS extends SubTask{
  int _id;
  String _sentence;
  List<String> _chunks; // Has two getters. One is chunks, the other is answer
  String _explanation;
  
  get id => this._id;

  set id( value) => this._id = value;

  get sentence => this._sentence;

  set sentence( value) => this._sentence = value;

  get answer => this._chunks;

  set answer( value) => this._chunks = value;

  get chunks{
    List<String>value = [];
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
    List<String> answer,
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
    List<String>chunkList=[];
    for(String chunk in question['chunks'])
      chunkList.add(chunk);
    
    return new JS(
      //id : question['id'],
      sentence : question['paragraph'],
      chunks : chunkList,
      explanation : question['explanation'],
      taskId : taskDetail['task_id'],
      topicId: taskDetail['topic_id'],
      subtaskId: question['subTask_id'],
      level: taskDetail['level'],
      taskName: taskDetail['name'],
      instruction: taskDetail['instruction'],
      instructionImage: taskDetail['instructionImage']

    );
  }

  Map<String,dynamic>toJS()
  { 
    Map<String,dynamic>map= new Map();
    if(id!=null)
      map['jsId']=id;
    map['Sentence']=sentence;
    map['Answer']=concatenateChunks(answer);
    map['Explanation']=explanation;
    map['SubtaskId']=subtaskId;
  
    return map;
  }

  factory JS.fromDatabase(Map<String,dynamic>taskDetails,Map<String,dynamic>questions)
  {   
    /*
    return new FB(
      id: questions['fbId'],
      paragraph : questions['Paragraph'],
      options : optionList,
      answers : answerList,
      explanation : explanationList,
      taskId : taskDetails['TopicTaskId'],
      subtaskId: questions['SubTask_id'],
      level: taskDetails['Level'],
      topicId: taskDetails['TopicId'],
      taskName: taskDetails['TaskType'],
      instruction: taskDetails['Instruction'],
      instructionImage: taskDetails['Instruction_Image']
    );
    */
    return new JS(
      id : questions['jsId'],
      sentence : questions['Sentence'],
      chunks : questions['Answer'].split(" "),
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

  void debugMessage()
  {
    print("Task_Id: "+taskId.toString());
    print("Level: "+level.toString());
    print("Taskname: "+taskName);
    print("TopicId: "+topicId.toString());
    print("SubtaskId: "+subtaskId.toString());
    print("JSId: "+id.toString());
    if(sentence!=null)
      print("Sentence: "+sentence);
    print("Chunks: "+chunks.toString());
    print("Answers: "+answer.toString());
    
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