import '../models/wp.dart';
import '../rest/wp.dart'; // just for testing
import '../db/wp.dart';
import '../db/task.dart';

class WPController {
  WPRest wpRest = new WPRest();
  WPDatabaseHelper wpDatabaseHelper = new WPDatabaseHelper();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  Future<void> _insertWPList(WPList wpList) async {
    List<WP> list = wpList.wpList;

    for (int i = 0; i < list.length; i++) {
      //must happen together. Will see if I can use a txaction
      
      //Image downloaded here, then value updated
      List<String> images=await list[i].downloadImages();
      list[i].images=images;


      taskDatabaseHelper.insertTask(list[i].toTask());
      taskDatabaseHelper.insertSubTask(list[i].toSubTask());
      
      //Image needs to be downloaded here
      wpDatabaseHelper.insertWP(list[i].toWP());
    }
  }

  Future<List<WP>> getWPList(
      String token, int topicId, int level, int limit, int offset) async {
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    //int count = await topicDatabaseHelper.getCount();
    WPList wpList;

    int count =
        await taskDatabaseHelper.getCount("Word to Picture", topicId);

    if (count == 0) {
      wpList = await wpRest.getWPList(token, topicId, level, limit, offset);
      _insertWPList(wpList);
    }

    List<WP> result = await wpDatabaseHelper.getWPList(topicId, level,
        limit: limit, offset: offset);
    return result;
  }
}
