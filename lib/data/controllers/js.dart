import '../models/js.dart';
import '../rest/js.dart'; // just for testing
import '../db/js.dart';
import '../db/task.dart';

class JSController {
  JSRest jsRest = new JSRest();
  JSDatabaseHelper jsDatabaseHelper = new JSDatabaseHelper();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  Future<void> _insertJSList(JSList jsList) async {
    List<JS> list = jsList.jsList;

    for (int i = 0; i < list.length; i++) {
      //must happen together. Will see if I can use a txaction
      taskDatabaseHelper.insertTask(list[i].toTask());
      taskDatabaseHelper.insertSubTask(list[i].toSubTask());
      jsDatabaseHelper.insertJS(list[i].toJS());
    }
  }

  Future<List<JS>> getJSList(
      String token, int topicId, int level, int limit, int offset) async {
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    //int count = await topicDatabaseHelper.getCount();
    JSList jsList;

    int count = await taskDatabaseHelper.getCount("Jumbled Sentence", topicId);
    print(count);

    if (count == 0) {
      jsList = await jsRest.getJSList(token, topicId, level, limit, offset);
      jsList.jsList[0].debugMessage();
      _insertJSList(jsList);
    }

    List<JS> result = await jsDatabaseHelper.getJSList(topicId, level,
        limit: limit, offset: offset);
    return result;
  }
}
