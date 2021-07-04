import '../models/token.dart';
import '../models/error.dart';
import '../rest/error.dart'; // just for testing
import '../db/error.dart';
import '../db/task.dart';

class ErrorController {
  ErrorRest errorRest = new ErrorRest();
  ErrorDatabaseHelper errorDatabaseHelper = new ErrorDatabaseHelper();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  Future<void> _insertErrorList(ErrorList errorList) async {
    List<Error> list = errorList.errorList;

    for (int i = 0; i < list.length; i++) {
      //must happen together. Will see if I can use a txaction
      await taskDatabaseHelper.insertTask(list[i].toTask());
      await taskDatabaseHelper.insertSubTask(list[i].toSubTask());
      await errorDatabaseHelper.insertError(list[i].toError());
    }
  }

  Future<List<Error>> getErrorList(
      String token, int topicId, int level, int limit, int offset) async {
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    //int count = await topicDatabaseHelper.getCount();
    ErrorList errorList;

    int count = await taskDatabaseHelper.getCount("Error In Sentence", topicId);
    print(count);

    if (count == 0) {
      errorList =
          await errorRest.getErrorList(token, topicId, level, limit, offset);

      if (errorList.errorList.isNotEmpty) {
        errorList.errorList[0].debugMessage();
      }

      await _insertErrorList(errorList);
    }

    List<Error> result = await errorDatabaseHelper.getErrorList(topicId, level,
        limit: limit, offset: offset);
    return result;
  }
}
