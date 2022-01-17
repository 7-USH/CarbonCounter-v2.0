// ignore_for_file: non_constant_identifier_names

import 'package:carbon_footprint/models/Indicator.dart';
import 'package:carbon_footprint/models/fieldCalc.dart';
import 'package:carbon_footprint/screens/home_screen.dart';
import 'package:carbon_footprint/screens/provider/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carbon_footprint/constants/themes.dart';
import 'package:provider/provider.dart';

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
  double footprint = 0;
  String fuelType = "";

  @override
  void initState() {
    super.initState();
    if (Provider.of<DataPage>(context, listen: false).selectedIndex == 0) {
      vehicleType = "Car";
    } else if (Provider.of<DataPage>(context, listen: false).selectedIndex ==
        1) {
      vehicleType == "Bus";
    } else if (Provider.of<DataPage>(context, listen: false).selectedIndex ==
        2) {
      vehicleType == "Train";
    } else {
      vehicleType = "Unknown";
    }
    fuelType = Provider.of<DataPage>(context, listen: false).getfuelType();
    setState(() {});
  }

  double carbonEmission = 0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final size = MediaQuery.of(context).size;
    String userCode = user.uid.toString();

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

              if (fuelType == "Petrol") {
                var carType =
                    Provider.of<DataPage>(context, listen: false).getCarType();
                if (carType == "Hatch back") {
                  footprint =
                      CarbonCalculator.cal_car_petrol_mil(24.5, distance);
                } else if (carType == "Sedan") {
                  footprint =
                      CarbonCalculator.cal_car_petrol_mil(25.16, distance);
                } else if (carType == "SUV") {
                  footprint =
                      CarbonCalculator.cal_car_petrol_mil(23.14, distance);
                }
              }

              if (fuelType == "Diesel") {
                var carType =
                    Provider.of<DataPage>(context, listen: false).getCarType();
                if (carType == "Hatch back") {
                  footprint =
                      CarbonCalculator.cal_car_diesel_mileage(24.5, distance);
                } else if (carType == "Sedan") {
                  footprint =
                      CarbonCalculator.cal_car_diesel_mileage(25.16, distance);
                } else if (carType == "SUV") {
                  footprint =
                      CarbonCalculator.cal_car_diesel_mileage(23.14, distance);
                }
              }

              if (fuelType == "CNG") {
                var carType =
                    Provider.of<DataPage>(context, listen: false).getCarType();
                if (carType == "Hatch back") {
                  footprint = CarbonCalculator.cal_car_cng(24.5, distance);
                } else if (carType == "Sedan") {
                  footprint = CarbonCalculator.cal_car_cng(25.16, distance);
                } else if (carType == "SUV") {
                  footprint = CarbonCalculator.cal_car_cng(23.14, distance);
                }
              }
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
                                "Travelling by " + vehicleType,
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
                                  Text((distance / 1000).toStringAsFixed(2) +
                                      " km")
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
                                    (footprint / 1000).toStringAsFixed(2) +
                                        " kg",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Provider.of<DataPage>(context, listen: false)
                                      .selectedIndex ==
                                  0) {
                                Provider.of<DataPage>(context, listen: false)
                                    .selectedIndex = 0;
                                Provider.of<DataPage>(context, listen: false)
                                    .setCarType("");
                                Provider.of<DataPage>(context, listen: false)
                                    .setFuelType("");
                              }
                              addData(userCode);
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  HomeScreen.id,
                                  ModalRoute.withName(HomeScreen.id));
                              // TODO: end journey phase
                              
                            },
                            child: Container(
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

  addData(String userCode) async {
    CollectionReference userData =
        FirebaseFirestore.instance.collection("Users");

    userData.snapshots().listen((snapshot) {});
    var docSnapshot = await userData.doc(userCode).get();
    var totalEmission = docSnapshot.get('totalEmission');
    totalEmission += double.parse((footprint / 1000).toStringAsFixed(2));
    carbonEmission = double.parse((footprint / 1000).toStringAsFixed(2));

    Map<String, dynamic> demodata = {
      "Distance": distance,
      "Emission": carbonEmission,
      "Type": vehicleType,
      "totalEmission": totalEmission
    };

    userData.doc(userCode).set(demodata);
  }
}
