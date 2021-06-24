import '../models/pw.dart';
import '../rest/pw.dart'; // just for testing
import '../db/pw.dart';
import '../db/task.dart';

class PWController {
  PWRest pwRest = new PWRest();
  PWDatabaseHelper pwDatabaseHelper = new PWDatabaseHelper();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  Future<void> _insertPWList(PWList pwList) async {
    List<PW> list = pwList.pwList;

    for (int i = 0; i < list.length; i++) {
      //must happen together. Will see if I can use a txaction
      
      //Image downloaded here, then value updated
      String imagePath=await list[i].downloadImage(list[i].image);
      list[i].image=imagePath;


      taskDatabaseHelper.insertTask(list[i].toTask());
      taskDatabaseHelper.insertSubTask(list[i].toSubTask());
      
      //Image needs to be downloaded here
      pwDatabaseHelper.insertPW(list[i].toPW());
    }
  }

  Future<List<PW>> getPWList(
      String token, int topicId, int level, int limit, int offset) async {
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    //int count = await topicDatabaseHelper.getCount();
    PWList pwList;

    int count =
        await taskDatabaseHelper.getCount("Picture to Word", topicId);

    if (count == 0) {
      pwList = await pwRest.getPWList(token, topicId, level, limit, offset);
      _insertPWList(pwList);
    }

    List<PW> result = await pwDatabaseHelper.getPWList(topicId, level,
        limit: limit, offset: offset);
    return result;
  }
}
