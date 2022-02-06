import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:karpull/screens/loginscreen.dart';

import 'package:karpull/services/authservice.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var name, username, password, confirm, token;
  bool puller = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Color.fromARGB(255, 56, 47, 14)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 199, 0))),
                  onChanged: (val) {
                    name = val;
                  }),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Color.fromARGB(255, 56, 47, 14)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 199, 0))),
                  onChanged: (val) {
                    username = val;
                  }),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Color.fromARGB(255, 56, 47, 14)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 199, 0))),
                  onChanged: (val) {
                    password = val;
                  }),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Color.fromARGB(255, 56, 47, 14)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 199, 0))),
                  onChanged: (val) {
                    confirm = val;
                  }),
            ),
          ),
          Switch(
            value: puller,
            onChanged: (value) {
              setState(() {
                puller = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Create Account'),
            color: Colors.yellow,
            onPressed: () {
              AuthService().createUser(
                  name, username, password, confirm, puller, context);
              // .then((val) async {
              // if (val.data['success']) {
              //   token = val.data['token'];
              //   final prefs = await SharedPreferences.getInstance();
              //   prefs.setString('token', token);
              //   Fluttertoast.showToast(
              //       msg: 'Logged In',
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 1,
              //       backgroundColor: Colors.green,
              //       textColor: Colors.white,
              //       fontSize: 16.0);
              // }
              // }
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
