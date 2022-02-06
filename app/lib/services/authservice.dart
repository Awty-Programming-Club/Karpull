import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/mainscreen.dart';

class AuthService {
  login(username, password, context) async {
    String url = 'http://localhost:3010/auth/signin';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"username": username, "password": password};
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
            (Route<dynamic> route) => false);
      }
    }
  }

  createUser(name, username, password, confirm, puller, context) async {
    String url = 'http://localhost:3010/auth/create-user';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "name": name,
      "username": username,
      "password": password,
      "confirm": confirm,
      "puller": puller
    };
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
            (Route<dynamic> route) => false);
      }
    }
  }
}
