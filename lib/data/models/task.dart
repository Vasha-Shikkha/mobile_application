class TopicTask{
  int _taskId;
  int _topicId;
  int _level;
  String _taskName;
  String _instruction;
  String _instructionImage;
  int get level => this._level;

  set taskId(int value) => this._taskId = value;

  get taskId => this._taskId;

  set instruction( value) => this._instruction = value;

  get instruction => this._instruction;

  set instructionImage( value) => this._instructionImage = value;

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
  });

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
      super(level:level,
            topicId:topicId,
            taskName:taskName,
            instruction: instruction,
            instructionImage: instructionImage
            );

}