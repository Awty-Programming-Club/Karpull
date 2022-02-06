import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karpull/screens/mainscreen.dart';
import 'package:karpull/screens/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Color.fromARGB(255, 56, 47, 14)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                    textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder(), fillColor: Color.fromARGB(255, 56, 47, 14)),
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
              child: Center(
                child: TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    onChanged: (val) {
                      password = val;
                    }),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.all(50.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              child: Text('Log In'),
              color: Color.fromARGB(255, 255, 199, 0),
              onPressed: () {
                AuthService()
                    .login(username, password, context)
                    .then((val) async {
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
                });
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              child: Text('Sign Up'),
              color: Color.fromARGB(255, 255, 199, 0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            ),
          )
        ]));
  }
}
