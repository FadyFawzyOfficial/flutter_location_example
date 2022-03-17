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
              Position? position = await _getCurrentLocation();
              setState(() => currentLocation =
                  _getLatitudeAndLongitude(position: position));
            },
          ),
        ],
      ),
    );
  }

  // This function checks for permissions if the app can use the location service
  // of the device or not and then return the current location of the device.
  Future<Position?> _getCurrentLocation() async {
    // First, we need to initialize a Position instance variable that hold the
    // location position value.

    // Then, we can use the LocationPermission instance provided by the geolocator
    // plugin to check if the permission.
    LocationPermission permission = await Geolocator.checkPermission();

    // First, we check if the permission to use location is already available for
    // the app using the checkPermission() method provided by the geolocator plugin.
    // If not then (Permission Denied),
    if (permission == LocationPermission.denied) {
      // we request to grant permission using requestPermission() method.
      permission = await Geolocator.requestPermission();

      // If we manually deny the permission then, we assign permission denied
      // value to currentLocation
      if (permission == LocationPermission.denied) return null;
    }

    // else we fetch the current location value using the getCurrentPosition
    // method and assign it to returned position value.

    // Now, returned position will hold the latitude and longitude value
    // which we will set to the currentLocation variable.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Return the String that demonstrates the Location Latitude & Longitude
  String _getLatitudeAndLongitude({required Position? position}) {
    if (position == null) return 'Permission Denied';
    return 'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
  }
}
