import 'package:flutter/material.dart';

import 'screens/current_location_screen.dart';

void main() => runApp(const LocationExample());

class LocationExample extends StatelessWidget {
  const LocationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CurrentLocationScreen(),
    );
  }
}
