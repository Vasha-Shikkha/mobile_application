import '../models/mcq.dart';
import '../rest/mcq.dart'; // just for testing
import '../db/mcq.dart';
import '../db/task.dart';

class MCQController {
  MCQRest mcqRest = new MCQRest();
  MCQDatabaseHelper mcqDatabaseHelper = new MCQDatabaseHelper();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  Future<void> _insertMCQList(MCQList mcqList) async {
    List<MCQ> list = mcqList.mcqList;

    for (int i = 0; i < list.length; i++) {
      //must happen together. Will see if I can use a txaction
      taskDatabaseHelper.insertTask(list[i].toTask());
      taskDatabaseHelper.insertSubTask(list[i].toSubTask());
      mcqDatabaseHelper.insertMCQ(list[i].toMCQ());
    }
  }

  Future<List<MCQ>> getMCQList(
      String token, int topicId, int level, int limit, int offset) async {
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    //int count = await topicDatabaseHelper.getCount();
    MCQList mcqList;

    int count = await taskDatabaseHelper.getCount("MCQ", topicId);
    print(count);

    if (count == 0) {
      mcqList = await mcqRest.getMCQList(token, topicId, level, limit, offset);
      mcqList.mcqList[0].debugMessage();
      _insertMCQList(mcqList);
    }

    List<MCQ> result = await mcqDatabaseHelper.getMCQList(topicId, level,
        limit: limit, offset: offset);
    return result;
  }
}
