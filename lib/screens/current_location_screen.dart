import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  String? currentLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal[50],
            child: Row(
              children: [
                const Icon(Icons.location_on_rounded),
                const SizedBox(width: 16),
                const Text('Location: '),
                const SizedBox(width: 4),
                if (currentLocation != null) Text(currentLocation!),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Get Location'),
            onPressed: () async {
              Position position = await _getCurrentLocation();
              setState(() {
                currentLocation =
                    'Latitude: ${position.latitude}\n Longitude: ${position.longitude}';
              });
            },
          ),
        ],
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions are denied the
  /// 'Future' will return an error.

  // This function checks for permissions if the app can use the location service
  // of the device or not and then return the current location of the device.
  Future<Position> _getCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      // Location services are not enabled don't continue accessing the position
      // and request users of the App to enable the location services.
      debugPrint('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again
        // (this is also where Android's shouldShowRequestPermissionRationale
        // returned true.) According to Android guidelines your App should show
        // an explanatory UI now.
        debugPrint('Location services are disabled.');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue accessing
    // the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
