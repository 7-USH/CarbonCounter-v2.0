import 'package:carbon_footprint/models/Indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carbon_footprint/constants/themes.dart';

class JourneyCounter extends StatefulWidget {
  const JourneyCounter({Key? key}) : super(key: key);
  static String id = "journey";

  @override
  _JourneyCounterState createState() => _JourneyCounterState();
}

class _JourneyCounterState extends State<JourneyCounter> {
  double distance = 0;
  Position? prevLocation;
  bool isVisibile = false;
  String vehicleType = "";

  @override
  void initState() {
    super.initState();
  }

  double CarbonEmission = 100;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final size = MediaQuery.of(context).size;
    vehicleType = "Car";

    return Scaffold(
      body: StreamBuilder(
        stream: Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
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
            return Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      (snapshot.data as Position).latitude,
                      (snapshot.data as Position).longitude,
                    ),
                    zoom: 15,
                    tilt: 30,
                  ),
                  onTap: (LatLng loc) {
                    setState(() {
                      isVisibile = !isVisibile;
                    });
                  },
                  mapType: MapType.normal,
                ),
                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: kPrimeColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.photoURL!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                user.displayName!,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Vehcile: " + vehicleType,
                                style: const TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  right: 0,
                  left: 0,
                  top: !isVisibile
                      ? size.height
                      : size.height - (size.height / 4),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 40,
                                      child: Image.network(
                                          "https://cdn-icons-png.flaticon.com/512/1196/1196775.png"),
                                    ),
                                  ),
                                  Text("Distance: " + distance.toString())
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 40,
                                      child: Image.network(
                                          "https://icon-library.com/images/co2-icon/co2-icon-8.jpg"),
                                    ),
                                  ),
                                  Text(
                                    "Footprint: " + 100.toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: kGreenOne,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.19),
                                  offset: const Offset(1, 10),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "End Journery",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Indicator();
          }
        },
      ),
    );
  }
}
