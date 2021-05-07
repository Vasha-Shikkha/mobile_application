import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';
import '../models/fb.dart';


class FBRest{
  NetworkUtil _netUtil = new NetworkUtil();

  Future< FBList >getFBList(String token,int topicId,int level,int limit,int offset){
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
    
    String requestURL = FB_URL+'?'+queryString;

    return _netUtil.get(requestURL, headers: headers).then((dynamic res){
      //topicList=new TopicList.fromJson(res);
      print("FB Necrozma");
      FBList fbList=new FBList.fromJson(res);
      return fbList;
    });
  }
}
