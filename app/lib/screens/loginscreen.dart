import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karpull/screens/signupscreen.dart';

import 'package:karpull/services/authservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var username, password, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          TextField(
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: (val) {
                username = val;
              }),
          TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              onChanged: (val) {
                password = val;
              }),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Log In'),
            color: Colors.yellow,
            onPressed: () {
              AuthService().login(username, password).then((val) {
                if (val.data['success']) {
                  token = val.data['token'];
                  Fluttertoast.showToast(
                      msg: 'Logged In',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });
            },
          ),
          RaisedButton(
            child: Text('Sign Up'),
            color: Colors.yellow,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
          )
        ]));
  }
}
