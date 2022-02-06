import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

import 'package:karpull/screens/loginscreen.dart';

import 'package:karpull/services/authservice.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var name, username, password, confirm, token;
  double puller = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (val) {
                name = val;
              }),
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
          TextField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
              onChanged: (val) {
                confirm = val;
              }),
          Slider(
            min: 0,
            max: 1,
            value: puller,
            onChanged: (value) {
              setState(() {
                puller = value;
              });
            },
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Create Account'),
            color: Colors.yellow,
            onPressed: () {
              AuthService()
                  .createUser(name, username, password, confirm, puller)
                  .then((val) {
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
            child: Text('Log In'),
            color: Colors.yellow,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ]));
  }
}
