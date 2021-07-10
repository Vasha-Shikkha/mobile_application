

import '../models/mcq.dart';
import '../rest/mcq.dart'; // just for testing

import '../db/mcq.dart';
import '../db/task.dart';
import '../db/pw.dart';

import '../db/error.dart';
import '../models/error.dart';

import '../db/sm.dart';
import '../db/wp.dart';
import '../models/pw.dart';

import '../rest/task.dart';

import '../db/fb.dart';
import '../models/fb.dart';

import '../db/js.dart';
import '../models/js.dart';

import '../models/task.dart';
import '../models/sm.dart';

class TaskController {
  TaskRest taskRest = new TaskRest();
  
  TaskDatabaseHelper taskDatabaseHelper = new TaskDatabaseHelper();
  PWDatabaseHelper pwDatabaseHelper = new PWDatabaseHelper();
  SMDatabaseHelper smDatabaseHelper = new SMDatabaseHelper();
  JSDatabaseHelper jsDatabaseHelper = new JSDatabaseHelper();
  FBDatabaseHelper fbDatabaseHelper = new FBDatabaseHelper();
  MCQDatabaseHelper mcqDatabaseHelper = new MCQDatabaseHelper();
  ErrorDatabaseHelper errorDatabaseHelper = new ErrorDatabaseHelper();

  Future<List<TaskList>> getTaskList(String token, int topicId, int level, int limit, int offset) async
  {
    //List<TaskList>list;
    List<TaskList>result=[];
    int count = await taskDatabaseHelper.getCount2(topicId,level,limit,offset);
    // print(count);
    //download. Will probably need to change it
    //This whole if-else ladder should probably be moved into a separate function/class
    if(count == 0)
    { 
      List<TaskList> tasks = await TaskRest().getTaskList(token, topicId, level, limit, offset);
      print("Geroro");
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
          else if(taskName == 'Jumbled Sentence')
          {
            print("In jumbled sentence block");
            await jsDatabaseHelper.insertJS(obj.toJS());
          }
          else if(taskName == 'Fill in the Blanks')
          {
            print("In FB Block");
            await fbDatabaseHelper.insertFB(obj.toFB());
          }
          else if(taskName == 'MCQ')
          {
            print("In MCQ");
            await mcqDatabaseHelper.insertMCQ(obj.toMCQ());
          }
          else if(taskName == 'Error in Sentence')
          {
            print("In Error in Sentence");
            await errorDatabaseHelper.insertError(obj.toError());
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
      print("Hello :"+taskName);

      if(taskName == 'Picture to Word')
      { 
        print("Chaiya Chaiya");
        List<PW>pwSubtasks=await pwDatabaseHelper.getPWs(topicId, level, taskDetail,limit:limit,offset:offset);
        print("Chaiya Chaiya");
        result.add(new TaskList(taskList:pwSubtasks,taskName: taskName));
      }
      else if(taskName == 'Sentence Matching')
      {
        print("Kamen Rider");
        List<SM>smSubtasks=await smDatabaseHelper.getSMs(topicId, level, taskDetail,limit:limit,offset:offset);
        result.add(new TaskList(taskList:smSubtasks,taskName: taskName));
      }
      else if(taskName == 'Jumbled Sentence')
      {
        print("Fate/Stay Night");
        List<JS>jsSubtasks= await jsDatabaseHelper.getJSs(topicId, level, taskDetail,limit:limit,offset:offset);
        result.add(new TaskList(taskList:jsSubtasks,taskName: taskName));
      }
      else if(taskName == 'Fill in the Blanks')
      {
        print("Tales of Berseria");
        List<FB>fbSubtasks= await fbDatabaseHelper.getFBs(topicId, level, taskDetail,limit:limit,offset:offset);
        result.add(new TaskList(taskList:fbSubtasks,taskName: taskName));
      }
      else if(taskName == 'MCQ')
      {
        print("Psycho Pass");
        List<MCQ>mcqSubtasks = await mcqDatabaseHelper.getMCQs(topicId, level, taskDetail,limit:limit,offset:offset);
        result.add(new TaskList(taskList:mcqSubtasks,taskName: taskName));
      }
      else if(taskName == 'Error in Sentence')
      {
        print("Eiyuuden");
        List<Error>errorSubtasks = await errorDatabaseHelper.getErrors(topicId, level, taskDetail,limit:limit,offset:offset);
        result.add(new TaskList(taskList:errorSubtasks,taskName: taskName));
      }
    
    }
    //print(result.length);
    return result;
  }

}

