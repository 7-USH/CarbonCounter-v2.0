import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class JourneyCounter extends StatefulWidget {
  JourneyCounter({Key? key}) : super(key: key);
  static String id = "journey";

  @override
  _JourneyCounterState createState() => _JourneyCounterState();
}

class _JourneyCounterState extends State<JourneyCounter> {
  Position? _currentLocation;
  double distance = 0;
  Position? prevLocation;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      } else if (permission != LocationPermission.deniedForever) {
        setState(() {});
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentLocation = await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo])),
        child: StreamBuilder(
          stream: Geolocator.getPositionStream(
            locationSettings: LocationSettings(
                accuracy: LocationAccuracy.best, distanceFilter: 100),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (prevLocation != null) {
                Position? location = (snapshot.data as Position?);
                distance += Geolocator.distanceBetween(
                    prevLocation!.latitude,
                    prevLocation!.longitude,
                    location!.latitude,
                    location.longitude);

                print("$distance");
              }
              prevLocation = snapshot.data as Position?;
              return Center(
                child: Text("$distance"),
              );
            } else {
              print(snapshot);
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
