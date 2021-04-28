import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';
import '../models/topic.dart';

import 'package:http/http.dart' as http;

class TopicRest{
  
  NetworkUtil _netUtil = new NetworkUtil();
  
  Future<TopicList> getAllTopics(String token){
    TopicList topicList;
    String t1="application/json";
    Map<String,String>headers = new Map();

    headers["Accept"]=t1;
    headers["Authorization"]="Bearer "+token;

    return _netUtil.get(TOPIC_URL, headers: headers).then((dynamic res){
      print("Reshiram");
      topicList=new TopicList.fromJson(res);
      return topicList;
    });
  }

  Future<TopicLevelCountList> getTopicCounts(String token){
    String t1="application/json";
    Map<String,String>headers = new Map();
  
    headers["Accept"]=t1;
    headers["Authorization"]="Bearer "+token;

    TopicLevelCountList topicLevelCountList;

    return _netUtil.get(EXERCISECOUNT_URL, headers: headers).then((dynamic res){
      topicLevelCountList=new TopicLevelCountList.fromJson(res);
      return topicLevelCountList;
    });
  
  }

}