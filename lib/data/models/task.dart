class TopicTask{
  int _level;
  String _taskName;
  int _topicId;
  String _topicTaskQuestion;
  int get level => this._level;

  set level(int value) => this._level = value;

  get taskName => this._taskName;

  set taskName( value) => this._taskName = value;

  get topicId => this._topicId;

  set topicId( value) => this._topicId = value;

  get topicTaskQuestion => this._topicTaskQuestion;

  set topicTaskQuestion( value) => this._topicTaskQuestion = value;

  TopicTask({
    int level,
    String taskName,
    int topicId,
    String topicTaskQuestion 
  });

}