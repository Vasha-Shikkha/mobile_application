import 'task.dart';


class SMList{
  List<SM> _smList;
  
  List<SM> get smList => this._smList;

  set smList(List<SM> value) => this._smList = value;

  SMList({
    List<SM>smList
  }):_smList= smList;

  factory SMList.fromJson(List<dynamic> json){
    
    List<SM>smList = [];
    for(dynamic element in json)
    {
      Map<String,dynamic>taskDetail=element['taskDetail'];
      List< dynamic >questions=element['questions']; 

      for(Map<String,dynamic>question in questions)
      {
        SM sm=new SM.fromJson(taskDetail,question);
        smList.add(sm);
      }
    }

    // print(pwList.length);

    return new SMList(smList:smList);
  }

}


class SM extends SubTask{
  int _id;
  String _leftPart;
  String _rightPart;
  String _explanation;
  
  get id => this._id;

  set id( value) => this._id = value;

  get leftPart => this._leftPart;

  set leftPart( value) => this._leftPart= value;

  get rightPart => this._rightPart;

  set rightPart( value) => this._rightPart = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  SM({
    int id,
    int subtaskId,
    int taskId,
    int level,
    int topicId,
    String taskName,
    String instruction,
    String instructionImage,
    String leftPart,
    String rightPart,
    String explanation,
  }): _id=id,
      _explanation=explanation,
      _leftPart=leftPart,
      super(
        taskId: taskId,
        subtaskId: subtaskId,
        level: level,
        topicId: topicId,
        taskName: taskName,
        instruction: instruction,
        instructionImage: instructionImage
      );

  factory SM.fromJson(Map<String,dynamic> taskDetail,Map<String,dynamic>question)
  { 

    //Map<String,dynamic>taskDetails= json['taskDetail'];
    //List<Map<String,dynamic> >questions 
    
    return new SM(
      id : question['id'],
      leftPart : question['left_part'],
      rightPart : question['right_part'],
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

  Map<String,dynamic>toSM()
  { 
    Map<String,dynamic>map= new Map();
    map['smId']=id;
    map['LeftPart'] = leftPart;
    map['RightPart']=rightPart;
    map['Explanation']=explanation;
    map['SubtaskId']=subtaskId;
  
    return map;
  }

  factory SM.fromDatabase(Map<String,dynamic>taskDetails,Map<String,dynamic>questions)
  {   
    
    return new SM(
      id : questions['smId'],
      leftPart : questions['LeftPart'],
      rightPart : questions['RightPart'],
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