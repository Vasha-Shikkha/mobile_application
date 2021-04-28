import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';
import '../models/fb.dart';

/*
class FBRest{
  NetworkUtil _netUtil = new NetworkUtil();

  Future< FB >getFB(String token,int topicId,int level){
    String t1="application/json";
    Map<String,dynamic>headers = new Map<String,dynamic>();

    headers["Content-Type"]=t1;
    headers["Authorization"]="Bearer "+token;
    headers["topic_id"]=topicId;
    headers["level"]=level;

    return _netUtil.get(TOPIC_URL, headers: headers).then((dynamic res){
      //topicList=new TopicList.fromJson(res);
      return topicList;
    });
  }
}
*/