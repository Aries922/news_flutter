import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_flutter/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Future<bool> authentication(String email, String password) async {
    var url = Uri.parse("http://nodejs-register-login-app.herokuapp.com/login");

    print("Sign API init -----");
    try {
      final responce = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      print("SignUP Status Code :  ${responce.statusCode}");
      print("SignUP Response Body :  ${responce.body}");
      final response = json.decode(responce.body);

      final responceData = json.decode(responce.body);
      print(responceData);
      print(responceData['Success']);


      if (responceData['Success'] == 'Success!')
        return true;
      else
        return false;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> authenticationSignup(
      String email, String username, String password, String password2) async {
    var urlCreate =
        Uri.parse("http://nodejs-register-login-app.herokuapp.com/");
    print("Sign API init -----");

    try {
      final responce = await http.post(urlCreate, body: {
        'email': email,
        'password': password,
        'username': username,
        'passwordConf': password2
      });
      print("SignUP Status Code :  ${responce.statusCode}");
      print("SignUP Response Body :  ${responce.body}");
      final responseData = json.decode(responce.body);

      notifyListeners();
    } catch (e) {
      print("Error " + e.toString());
      throw e;
    }
    print("Sign API end -----");
  }

  Future<bool> login(String email, String password) {
    return authentication(email, password);
  }

  Future<void> signUp(
      String email, String username, String password, String password2) {
    return authenticationSignup(email, username, password, password2);
  }

  Future<bool> autoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(EMAILKEY)) {
      String email = sharedPreferences.getString(EMAILKEY)!;
      String password = sharedPreferences.getString(PASSWORDKEY)!;
      print(email+" Email");
      print(password);
      return await login(email, password);
    }
    return false;
  }
}
