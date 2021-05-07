class TopicTask{
  int _taskId;
  int _topicId;
  int _level;
  String _taskName;
  String _instruction;
  String _instructionImage;
  
  set taskId(int value) => this._taskId = value;

  get taskId => this._taskId;

  set instruction( value) => this._instruction = value;

  get instruction => this._instruction;

  set instructionImage( value) => this._instructionImage = value;
  
  get instructionImage => this._instructionImage;

  get level => this._level;
  
  set level(int value) => this._level = value;

  get taskName => this._taskName;

  set taskName( value) => this._taskName = value;

  get topicId => this._topicId;

  set topicId( value) => this._topicId = value;

  TopicTask({
    int taskId,
    int level,
    String taskName,
    int topicId,
    String instruction,
    String instructionImage 
  }):_taskId=taskId,
    _level=level,
    _taskName=taskName,
    _topicId=topicId,
    _instruction=instruction,
    _instructionImage=instructionImage;

  Map<String,dynamic>toTask()
  { 
    Map<String,dynamic>map= new Map();
    
    map['TopicTaskId']=taskId;
    map['TaskType']=taskName;
    map['TopicId']=topicId;
    map['Level']=level;
    map['Instruction']=instruction;
    map['Instruction_Image']=instructionImage;    
    
    return map;
  }

}

class SubTask extends TopicTask{

  //int _taskId;
  int _subtaskId;
  
  int get subtaskId => this._subtaskId;

  set subtaskId(int value) => this._subtaskId = value;

  SubTask({
    int taskId,
    int subtaskId,
    int level,
    int topicId,
    String taskName,
    String instruction,
    String instructionImage
  }):_subtaskId=subtaskId,
      super(
            taskId: taskId,
            level:level,
            topicId:topicId,
            taskName:taskName,
            instruction: instruction,
            instructionImage: instructionImage
            );

  Map<String,dynamic>toSubTask()
  { 
    Map<String,dynamic>map= new Map();
    
    map['SubtaskId']=subtaskId;
    map['TopicTaskId']=taskId;
    
    return map;
  } 

}