import 'dart:async';

import 'package:Vasha_Shikkha/utils/network_util.dart';

class RestApi {
  NetworkUtil _netUtil = new NetworkUtil();
  static const BASE_URL = "http://192.168.43.225:8000/api";
  static const LOGIN_URL = BASE_URL + "/login";
  static const REG_URL = BASE_URL + "/register";

  static const API_KEY = "somerandomkey";

  Future<Map<String, dynamic>> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "email": username,
      "password": password,
    }).then((dynamic res) {
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");
      if (res["error"] == "Unauthorised") throw new Exception(res["error"]);
      return res["success"];
    });
  }

  Future<Map<String, dynamic>> register(
      String email, String username, String password) {
    return _netUtil.post(REG_URL, body: {
      "name": username,
      "email": email,
      "password": password,
      "c_password": password,
    }).then((dynamic res) {
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");
      if (res["error"] == "Unauthorised") throw new Exception(res["error"]);
      return res["success"];
    });
  }
}
