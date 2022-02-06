import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:karpull/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:karpull/services/authservice.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var user;
  var here = false;
  var distance = 0;
  Timer? timer;

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (user != null) {
      return;
    }
    ;
    var tempUser = await AuthService().getUser(token);
    setState(() {
      user = tempUser;
    });
  }

  void sendLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await AuthService().sendLocation(token, position);
    setState(() {
      here = response['here'];
    });
    setState(() {
      distance = response['distance'].round();
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (user['partner'] != null) {
        sendLocation();
      }
    });
    super.initState();
  }

  var partnerUsername;

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
      if (user == null || (user['partner'] == null && (user['puller'] == true)))
        (Column(children: [
          TextField(
              decoration: InputDecoration(labelText: 'Partner Username'),
              onChanged: (val) {
                setState(() {
                  partnerUsername = val;
                });
              }),
          RaisedButton(
            child: Text("Submit"),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('token');
              await AuthService().setPartner(partnerUsername, token, context);
            },
          )
        ])),
      if (user != null && user['partner'] != null)
        (Column(children: [
          Text(here.toString()),
          Text(distance.toString() + "m")
        ])),
      RaisedButton(
          child: Text("Back"),
          color: Colors.yellow,
          onPressed: () {
            // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            // sharedPreferences.setString("token", "");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }),
    ]));
  }
}
