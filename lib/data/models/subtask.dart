import 'task.dart';

class SubTask extends TopicTask{

  //int _taskId;
  int _subtaskId;
  
  int get subtaskId => this._subtaskId;

  set subtaskId(int value) => this._subtaskId = value;


}