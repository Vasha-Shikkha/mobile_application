import '../models/sm.dart';
import '../rest/sm.dart'; // just for testing
import '../db/sm.dart';
import '../db/task.dart';

class SMController {
  SMRest smRest = new SMRest();
  SMDatabaseHelper smDatabaseHelper = new SMDatabaseHelper();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  Future<void> _insertSMList(SMList smList) async {
    List<SM> list = smList.smList;

    for (int i = 0; i < list.length; i++) {
      //must happen together. Will see if I can use a txaction
    
      taskDatabaseHelper.insertTask(list[i].toTask());
      taskDatabaseHelper.insertSubTask(list[i].toSubTask());
      
      
      smDatabaseHelper.insertSM(list[i].toSM());
    }
  }

  Future<List<SM>> getSMList(
      String token, int topicId, int level, int limit, int offset) async {
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    //int count = await topicDatabaseHelper.getCount();
    SMList smList;

    int count =
        await taskDatabaseHelper.getCount("Sentence Matching", topicId);

    if (count == 0) {
      smList = await smRest.getSMList(token, topicId, level, limit, offset);
      _insertSMList(smList);
    }

    List<SM> result = await smDatabaseHelper.getSMList(topicId, level,
        limit: limit, offset: offset);
    return result;
  }
}
