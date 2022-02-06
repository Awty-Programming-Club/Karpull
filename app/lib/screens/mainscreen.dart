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
  var here = true;
  var distance = 10;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (user == null ||
              (user['partner'] == null && (user['puller'] == true)))
            Center(
              child: (Column(children: [
                Container(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 56, 47, 14)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Partner Username',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 199, 0))),
                      onChanged: (val) {
                        setState(() {
                          partnerUsername = val;
                        });
                      }),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: RaisedButton(
                    child: Text("Submit"),
                    color: Color.fromARGB(255, 255, 199, 0),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? token = prefs.getString('token');
                      await AuthService()
                          .setPartner(partnerUsername, token, context);
                    },
                  ),
                )
              ])),
            ),
          if (user != null && user['partner'] != null)
            Center(
              child: (Column(children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Container(
                    child: here
                        ? Center(
                            child: Text(
                              "Here",
                              style: TextStyle(
                                color: Color.fromARGB(255, 21, 20, 1),
                                fontSize: 30,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Approaching",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 199, 0),
                                fontSize: 30,
                              ),
                            ),
                          ),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: new BoxDecoration(
                      color: here
                          ? Color.fromARGB(255, 255, 199, 0)
                          : Color.fromARGB(255, 21, 20, 1),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 255, 212, 58), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                        )
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    child: Text(distance.toString() + "m",
                        style:
                            TextStyle(color: Color.fromARGB(255, 255, 199, 0))))
              ])),
            ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: RaisedButton(
                child: Text("Back"),
                color: Color.fromARGB(255, 255, 199, 0),
                onPressed: () {
                  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  // sharedPreferences.setString("token", "");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ),
        ],
      ),
    );
  }
}
