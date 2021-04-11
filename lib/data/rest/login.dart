import 'dart:async';

import '../../utils/network_util.dart';
import '../../config.dart';

import '../models/token.dart';

class LoginRest {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<String> register(
    String username, String phoneNumber, String password) {
    //String t1 = "application/x-www-form-urlencoded";
    //String t2 = "application/json";
    String t1= "application/json";
    
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    //headers["Accept"] = t2;

    return _netUtil.post(REG_URL, headers: headers, body: {
      "name": username,
      "phone": phoneNumber,
      "password": password,
    }).then((dynamic res) {
      
      //There will be checks here
      return "Registration successful";
    });
  }


  Future<Token> login(String phoneNumber, String password) {
    //String t1 = "application/x-www-form-urlencoded";
    //String t2 = "application/json";
    String t1="application/json";
    //String t2="*/*";
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    //headers["Accept"] = t2;

    return _netUtil.post(LOGIN_URL,
        headers: headers,
        body: {"phone": phoneNumber, "password": password}).then((dynamic res) {
      /*
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      */
      //print(res.runtimeType.toString());
      
      if(res.containsKey('error')){
        throw new Exception(res['error']);
      }
      return new Token.fromJson(res);
    });
  }

  
}
