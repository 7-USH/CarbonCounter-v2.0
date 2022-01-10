// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, must_be_immutable, unnecessary_this, avoid_print, use_key_in_widget_constructors, unused_import, non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:async';

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/models/BusDetails.dart';
import 'package:carbon_footprint/models/CarDetails.dart';
import 'package:carbon_footprint/models/tiles.dart';
import 'package:carbon_footprint/screens/journery.dart';
import 'package:carbon_footprint/screens/login_screen.dart';
import 'package:carbon_footprint/screens/provider/data.dart';
import 'package:carbon_footprint/screens/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class EmissionPage extends StatefulWidget {
  EmissionPage({Key? key}) : super(key: key);

  @override
  _EmissionPageState createState() => _EmissionPageState();
}

class _EmissionPageState extends State<EmissionPage> {
  bool _onCreatePage = false;
  int selectedIndex = 0;

  List widgetList = [
    CarDetails(),
    BusDetails(),
    CarDetails(),
    BusDetails(),
    CarDetails(),
    CarDetails(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      _onCreatePage = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double pinVisible = size.height / 11;
    double pinInvisible = size.height / 1.2;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo])),
        child: Scaffold(
            bottomNavigationBar: EmissionBottomBar(size: size),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                elevation: 0,
                leading: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                  ],
                )),
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 25.0, right: 20.0),
                  height: size.height / 6,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Journey Time",
                        style: GoogleFonts.lobster(
                            color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                ),
                AnimatedPadding(
                  curve: Curves.easeInOutBack,
                  duration: Duration(seconds: 1),
                  padding: EdgeInsets.only(
                      top: _onCreatePage ? pinVisible : pinInvisible),
                  child: Container(
                    height: size.height * 4 / 6.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(5, 7),
                              spreadRadius: 1,
                              blurRadius: 8),
                        ]),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("How are you travelling ?",
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: kTextColor)),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 150,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: Utils.getEmissionTiles().length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      selectedIndex = index;
                                      setState(() {
                                        Provider.of<DataPage>(context,
                                                listen: false)
                                            .getIndex(index);
                                      });
                                    },
                                    child: ModeTiles(
                                      index: index,
                                      selectedIndex: selectedIndex,
                                    ));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Details",
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: kTextColor)),
                          SizedBox(
                            height: 20,
                          ),
                          widgetList[selectedIndex],
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class EmissionBottomBar extends StatefulWidget {
  const EmissionBottomBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<EmissionBottomBar> createState() => _EmissionBottomBarState();
}

class _EmissionBottomBarState extends State<EmissionBottomBar> {
  LocationPermission? permission;
  Future<void> _askPermission() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
  }

  bool errorButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.only(bottom: 15, top: 10),
        height: widget.size.height / 10,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kPrimeColor, kGreenOne]),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.19),
                offset: const Offset(1, -2),
                spreadRadius: 1,
                blurRadius: 8),
          ],
        ),
        child: Center(
          child: GestureDetector(
            onTap: () async {
              _askPermission();
              if (permission == LocationPermission.whileInUse ||
                  permission == LocationPermission.always) {
                if (Provider.of<DataPage>(context, listen: false)
                            .getCarType() !=
                        "" &&
                    Provider.of<DataPage>(context, listen: false)
                            .getfuelType() !=
                        "") {
                  Navigator.pushNamed(context, JourneyCounter.id);
                } else {
                  Vibration.vibrate(duration: 500);
                  setState(() {
                    Timer(Duration(milliseconds:500 ), () {
                      errorButton = ! errorButton;
                      setState(() {
                        
                      });
                      print(
                          "inside" + errorButton.toString()); //prints true
                    });
                    errorButton = !errorButton;
                    print(errorButton); // prints false
                  });
                }
              }
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: errorButton == true
                      ? Colors.red.withOpacity(0.8)
                      : Colors.white.withOpacity(0.95),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.19),
                        offset: const Offset(1, 10),
                        spreadRadius: 1,
                        blurRadius: 8),
                  ]),
              child: Center(child: Text("Start Journery")),
            ),
          ),
        ));
  }
}

class ModeTiles extends StatelessWidget {
  int selectedIndex;

  ModeTiles({
    required this.index,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);
  int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Utils.getEmissionTiles()[index].color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.19),
                    offset: const Offset(1, 4),
                    spreadRadius: 1,
                    blurRadius: 8),
                BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    offset: const Offset(-3, -4),
                    spreadRadius: -2,
                    blurRadius: 20),
              ]),
          child: Center(
            child: Icon(
              Utils.getEmissionTiles()[index].icon,
              color: index == selectedIndex ? Colors.white : Colors.black,
              size: 60,
            ),
          ),
        ),
        Text(Utils.getEmissionTiles()[index].mode)
      ],
    );
  }
}
