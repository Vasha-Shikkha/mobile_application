import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';
import '../models/sm.dart';


class SMRest{
  NetworkUtil _netUtil = new NetworkUtil();

  Future< SMList >getSMList(String token,int topicId,int level,int limit,int offset){
    String t1="application/json";
    Map<String,String>headers = new Map();

    headers["Accept"]=t1;
    headers["Authorization"]="Bearer "+token;
    
    Map<String,String> queryParameters=new Map();
    queryParameters["topic_id"]=topicId.toString();
    queryParameters["level"]=level.toString();
    queryParameters["limit"]=limit.toString();
    queryParameters["offset"]=offset.toString();

    String queryString = Uri(queryParameters: queryParameters).query;
    
    String requestURL = Error_URL+'?'+queryString;

    return _netUtil.get(requestURL, headers: headers).then((dynamic res){
      //topicList=new TopicList.fromJson(res);
      print("SM Necrozma");
      SMList smList=new SMList.fromJson(res);
      return smList;
    });
  }
}
