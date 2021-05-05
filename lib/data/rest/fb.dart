import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';
import '../models/fb.dart';


class FBRest{
  NetworkUtil _netUtil = new NetworkUtil();

  Future< FBList >getFBs(String token,int topicId,int level,int limit,int offset){
    String t1="application/json";
    Map<String,String>headers = new Map();

    headers["Accept"]=t1;
    headers["Authorization"]="Bearer "+token;
    headers["topic_id"]=topicId.toString();
    headers["level"]=level.toString();
    headers["limit"]=limit.toString();
    headers["offset"]=offset.toString();

    return _netUtil.get(TOPIC_URL, headers: headers).then((dynamic res){
      //topicList=new TopicList.fromJson(res);
      print("FB Necrozma");
      FBList fbList=new FBList.fromJson(res);
      return fbList;
    });
  }
}
