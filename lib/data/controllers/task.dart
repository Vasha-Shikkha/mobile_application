

import '../models/mcq.dart';
import '../rest/mcq.dart'; // just for testing

import '../db/mcq.dart';
import '../db/task.dart';
import '../db/pw.dart';
import '../db/fb.dart';
import '../db/error.dart';
import '../db/js.dart';
import '../db/sm.dart';
import '../db/wp.dart';
import '../models/pw.dart';

import '../rest/task.dart';

import '../models/task.dart';
import '../models/sm.dart';

class TaskController {
  TaskRest taskRest = new TaskRest();
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  PWDatabaseHelper pwDatabaseHelper = new PWDatabaseHelper();
  SMDatabaseHelper smDatabaseHelper = new SMDatabaseHelper();

  Future<List<TaskList>> getTaskList(String token, int topicId, int level, int limit, int offset) async
  {
    //List<TaskList>list;
    List<TaskList>result=[];
    int count = await taskDatabaseHelper.getCount2(topicId,level,limit,offset);
    
    //download. Will probably need to change it
    if(count == 0)
    { 
      List<TaskList> tasks = await TaskRest().getTaskList(token, topicId, level, limit, offset);
      
      for(TaskList task in tasks)
      {
        // the taskdetails for every task in a tasklist is the same
        for(int i=0;i< task.taskList.length;i++)
        { 
          String taskName=task.taskList[i].taskName;
          dynamic obj = task.taskList[i];
          
          // obj.debugTaskMessage();

          // print("Task to DB");
          await taskDatabaseHelper.insertTask(obj.toTask());//it will simply replace the same task
          print("SubTask to DB");
          await taskDatabaseHelper.insertSubTask(obj.toSubTask());

          if(taskName == 'Picture to Word')
          { 
            print("In Pic2Word block");
            String imagePath = await obj.downloadImage(obj.image); 
            obj.image=imagePath;
            await pwDatabaseHelper.insertPW(obj.toPW());
          }
          else if(taskName == 'Sentence Matching')
          {
            print("In Sentence Matching block");
            await smDatabaseHelper.insertSM(obj.toSM());
          }
        }
      }
    
    }

    List<TopicTask>taskDetails=await taskDatabaseHelper.getTasks(topicId, level,limit:limit,offset: offset);
    print("Length dd :"+taskDetails.length.toString());
    
    
    for(TopicTask taskDetail in taskDetails)
    { 
      taskDetail.debugTaskMessage();

      String taskName= taskDetail.taskName;
      if(taskName == 'Picture to Word')
      { 
        print("Chaiya Chaiya");
        List<PW>pwSubtasks=await pwDatabaseHelper.getPWs(topicId, level, taskDetail,limit:limit,offset:offset);
        print("Chaiya Chaiya");
        result.add(new TaskList(taskList:pwSubtasks));
      }
      else if(taskName == 'Sentence Matching')
      {
        print("Kamen Rider");
        List<SM>smSubtasks=await smDatabaseHelper.getSMs(topicId, level, taskDetail,limit:limit,offset:offset);
        result.add(new TaskList(taskList:smSubtasks));
      }
    }
    //print(result.length);
    return result;
  }

}

