import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  login(username, password) async {
    try {
      return await dio.post('http://localhost:3010/auth/signin',
          data: {"username": username, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  createUser(name, username, password, confirm, puller) async {
    return await dio.post('http://localhost:3010/auth/create-user',
        data: {
          "name": name,
          "username": username, 
          "password": password,
          "confirm": username,
          "puller": puller
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

}
