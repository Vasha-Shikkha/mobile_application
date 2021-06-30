import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';
import '../models/error.dart';

import '../models/task.dart';
class TaskRest {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<List<TaskList> > getTaskList(String token,int topicId,int level,int limit,int offset){
    String t1="application/json";
    Map<String,String>headers = new Map();

    headers["Accept"]=t1;
    headers["Authorization"] = "Bearer "+token;

    Map<String,String> queryParameters=new Map();
    queryParameters["topic_id"]=topicId.toString();
    queryParameters["level"]=level.toString();
    queryParameters["limit"]=limit.toString();
    queryParameters["offset"]=offset.toString();

    String queryString = Uri(queryParameters: queryParameters).query;
  
    String requestURL = TASK_URL+'?'+queryString;
  
    return _netUtil.get(requestURL, headers: headers).then((dynamic res){
      //print(res);
      List<TaskList>tasks = [];
      int taskCount = res['total'];
      // print(taskCount);
      List<dynamic>questionSet= res['questionSet'];
      for(dynamic element in questionSet)
      { 
        if(element['question'].length==0)
          continue;
        TaskList taskList= new TaskList.fromJson(element);
        tasks.add(taskList);
      }
      
      // print(taskList.taskList.length);
      print(tasks.length);
      return tasks;

    });
  }
  
}