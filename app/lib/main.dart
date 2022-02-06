import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationApp(),
    );
  }
}

class LocationApp extends StatefulWidget {
  // const LocationApp({Key? key}) : super(key: key);

  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator().getLastKnownPosition();

    setState(() {
      locationMessage = "$position.latitude, $position.longitude";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 46,
              color: Colors.yellow,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Get user location',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(locationMessage),
            FlatButton(
                onPressed: () {
                  getCurrentLocation();
                },
                color: Colors.blue[800],
                child: Text('Get Current Location',
                    style: TextStyle(
                      color: Colors.white,
                    )))
          ],
        ),
      ),
    );
  }
}
