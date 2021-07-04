import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';
import '../models/dict.dart';

class DictRest{

  NetworkUtil _netUtil = new NetworkUtil();
  Future<Dictionary>getDictionary(String token)
  {
    String t1="application/json";
    Map<String,String>headers = new Map();

    headers["Accept"]=t1;
    headers["Authorization"]="Bearer "+token;

    String requestURL = DICT_URL;

    return _netUtil.get(requestURL,headers: headers).then((dynamic res)
    {
      Dictionary dictionary=new Dictionary.fromJson(res['dictionary']);
      return dictionary;
    }
    );
  
  }

}

