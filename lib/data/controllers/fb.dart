import '../models/fb.dart';
import '../rest/fb.dart'; // just for testing
import '../db/fb.dart';
import '../db/task.dart';

class FBController {
  FBRest fbRest = new FBRest();
  FBDatabaseHelper fbDatabaseHelper = new FBDatabaseHelper();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  Future<void> _insertFBList(FBList fbList) async {
    List<FB> list = fbList.fbs;

    for (int i = 0; i < list.length; i++) {
      //must happen together. Will see if I can use a txaction
      taskDatabaseHelper.insertTask(list[i].toTask());
      taskDatabaseHelper.insertSubTask(list[i].toSubTask());
      fbDatabaseHelper.insertFB(list[i].toFB());
    }
  }

  Future<List<FB>> getFBList(
      String token, int topicId, int level, int limit, int offset) async {
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    //int count = await topicDatabaseHelper.getCount();
    FBList fbList;

    int count =
        await taskDatabaseHelper.getCount("Fill in the Blanks", topicId);

    if (count == 0) {
      fbList = await fbRest.getFBList(token, topicId, level, limit, offset);
      _insertFBList(fbList);
    }

    List<FB> result = await fbDatabaseHelper.getFBList(topicId, level,
        limit: limit, offset: offset);
    return result;
  }
}
