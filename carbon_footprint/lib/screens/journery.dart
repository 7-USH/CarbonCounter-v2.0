import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:carbon_footprint/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velocity_x/src/flutter/shimmer.dart';

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

  double CarbonEmission = 100;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
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
              }
              prevLocation = snapshot.data as Position?;
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: kGreenOne,
                          // ignore: prefer_const_constructors
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(user.photoURL!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Journey Details",
                        textScaleFactor: 1.5,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$CarbonEmission",
                            textScaleFactor: 2.5,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            " CO₂eKg",
                            textScaleFactor: 1.5,
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: CustomContainer(
                              text: "Distance",
                              value: distance,
                              image:
                                  "https://cdn-icons-png.flaticon.com/512/1196/1196775.png",
                            ),
                          ),
                          Expanded(
                            child: CustomContainer(
                              text: "Footprint",
                              value: CarbonEmission,
                              image:
                                  "https://icon-library.com/images/co2-icon/co2-icon-8.jpg",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.7),
                              border: Border.all(color: kPrimeColor, width: 10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.19),
                                  offset: const Offset(1, 10),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(_currentLocation!.latitude,
                                      _currentLocation!.longitude),
                                  zoom: 15,
                                ),
                                mapType: MapType.normal,
                              ),
                            ),
                          ),
                        ),
                      )
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
    required this.text,
    required this.value,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.19),
                  offset: const Offset(1, 10),
                  spreadRadius: 1,
                  blurRadius: 8),
            ],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Expanded(child: Image.network(image)),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(child: FittedBox(child: Text(text))),
                    Expanded(child: Text(value.toString())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
