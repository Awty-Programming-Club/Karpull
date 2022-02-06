import 'package:flutter/material.dart';
import 'package:karpull/screens/loginscreen.dart';
import 'package:karpull/screens/mainscreen.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp (
        title: 'Account',
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 21, 20, 1),
          primarySwatch: Colors.yellow,
        ),
        home: LoginScreen(),
      );
    }
}