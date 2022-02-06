import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:karpull/services/authservice.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          RaisedButton(
            child: Text('Get User Data'),
            color: Colors.yellow,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('token');
              var user = await AuthService().getUser(token);
              print(user);
            },
          ),
        ]));
  }
}
