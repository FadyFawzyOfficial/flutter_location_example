import 'package:flutter/material.dart';

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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
