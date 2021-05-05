import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/js.dart';

class JSRest{

  NetworkUtil _netUtil = new NetworkUtil();
  
  Future<JSList> getJumbledWords(String token,int topicId,int level,int limit,int offset){
    JSList jsList;
    String t1="application/json";
    Map<String,String>headers = new Map();

    headers["Accept"]=t1;
    headers["Authorization"]="Bearer "+token;
    headers["topic_id"]=topicId.toString();
    headers["level"]=level.toString();
    headers["limit"]=limit.toString();
    headers["offset"]=offset.toString();

    return _netUtil.get(TOPIC_URL, headers: headers).then((dynamic res){
      //print("Reshiram");
      jsList=new JSList.fromJson(res);
      return jsList;
    });
  }

}