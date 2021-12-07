import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:carbon_footprint/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';

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
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your journey data:",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: [
                            CustomContainer(
                                image:
                                    "https://image.shutterstock.com/image-illustration/city-map-pin-pointers-3d-260nw-1566197275.jpg",
                                text: "Total distance travelled",
                                value: distance),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  String image = "";
  String text = "";
  double value = 0;
  CustomContainer({
    Key? key,
    required this.image,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text + ": $value",
                style: GoogleFonts.ptSerif(
                    color: kTextColor.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
