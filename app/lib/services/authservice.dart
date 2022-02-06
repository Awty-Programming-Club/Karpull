import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:karpull/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/mainscreen.dart';

//ANDROID
// var serverURL = '10.0.2.2';
//APPLE
var serverURL = 'localhost';

class AuthService {
  login(username, password, context) async {
    String url = 'http://$serverURL:3010/auth/signin';
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
    String url = 'http://$serverURL:3010/auth/create-user';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "name": name,
      "username": username,
      "password": password,
      "confirm": confirm,
      // "puller": puller,
    };
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    if (res.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  getUser(token) async {
    String url = 'http://$serverURL:3010/user/';
    var jsonResponse;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    var res = await http.get(Uri.parse(url), headers: requestHeaders);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        return jsonResponse;
      }
    }
  }

  setPartner(username, token, context) async {
    String url = 'http://$serverURL:3010/user/set-partner';
    var jsonResponse;
    var body = jsonEncode({"username": username});
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    var res =
        await http.post(Uri.parse(url), body: body, headers: requestHeaders);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
            (Route<dynamic> route) => false);
      }
    }
  }

  sendLocation(token, position) async {
    String url = 'http://$serverURL:3010/user/update-location';
    var jsonResponse;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    var body = jsonEncode(
        {"latitude": position.latitude, "longitude": position.longitude});
    var res =
        await http.post(Uri.parse(url), body: body, headers: requestHeaders);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {
        return jsonResponse;
      }
    }
  }
}
