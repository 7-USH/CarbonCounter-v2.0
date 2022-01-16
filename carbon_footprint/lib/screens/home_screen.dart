// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/models/tiles.dart';
import 'package:carbon_footprint/screens/emission_screen.dart';
import 'package:carbon_footprint/widgets/bottom_navigation.dart';
import 'package:carbon_footprint/widgets/circular_chart.dart';
import 'package:carbon_footprint/widgets/info_tiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";
  HomeScreen({Key? key}) : super(key: key);

  final CollectionReference userData =
      FirebaseFirestore.instance.collection("Users");

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalEmission = 0;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    addUser();
  }

  Widget myCustomButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EmissionPage.id).then((_) {
          // you have come back to your Settings screen
          HomeScreen();

        });  
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 60,
        width: 200,
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [kPrimeColor, kGreenOne]),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.19),
                  offset: const Offset(1, 10),
                  spreadRadius: 1,
                  blurRadius: 8),
            ],
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            "Reduce Emission",
            style: GoogleFonts.firaSans(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ).shimmer(
              primaryColor: Colors.white,
              secondaryColor: kPrimeColor,
              duration: const Duration(seconds: 6)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();
    String name = user.displayName!;

    String newName = name.split(" ")[0].firstLetterUpperCase();

    return totalEmission.isNaN
        ? CircularProgressIndicator()
        : Scaffold(
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [kPrimeColor, kGreenOne, kGreenTwo])),
                child: const MyButtomNavigationBar()),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kPrimeColor, kGreenOne, kGreenTwo])),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 22),
                      color: Colors.transparent,
                      height: size.height / 7,
                      width: size.width,
                      child: Row(
                        children: [
                          // ignore: prefer_const_constructors
                          CircleAvatar(
                            radius: 44,
                            backgroundColor: kPrimeColor,
                            // ignore: prefer_const_constructors
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(user.photoURL!),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMMMd().format(now),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Hey, ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                          children: [
                                        TextSpan(
                                            text: newName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3),
                                      ])).shimmer(
                                      primaryColor: kTextColor,
                                      secondaryColor:
                                          kPrimeColor.withOpacity(0.6)),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              // TODO: homepage menu/ drawer
                            },
                            icon: const Icon(Icons.menu, color: kTextColor),
                          ),
                        ],
                      ),
                    ),
                    CircularChart(
                      // TODO: here enter the Calculated Number
                      // and percentage of Co2 Emission as of today

                      calculationNumber: totalEmission,
                      width: size.width / 3,
                      height: size.height / 3,
                      painter: ProgressPainter(
                          circleWidth: size.width / 17,
                          completedPercentage: totalEmission,
                          defaultCircleColor: kSecondaryColor.withOpacity(1),
                          percentageCompletedCircleColor: kPrimeColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "So far this month",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Container(
                      height: size.height / 5,
                      width: double.infinity,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: Utils.getTiles().length,
                          itemBuilder: (BuildContext, index) {
                            return InfoTiles(
                                color: Utils.getTiles()[index].color,
                                icon: Utils.getTiles()[index].icon,
                                text: Utils.getTiles()[index].sentence,
                                percent: Utils.getTiles()[index].emission);
                          }),
                    ),
                    myCustomButton(context)
                  ],
                ),
              ),
            ),
          );
  }

  addUser() async {
    Map<String, dynamic> demodata = {
      "Distance": 0,
      "Emission": 0,
      "Type": "",
      "totalEmission": 0
    };

    bool isPresent = false;

    String userCode = user.uid.toString();
    final CollectionReference userData =
        FirebaseFirestore.instance.collection("Users");

    await userData.get().then((querySnapshot) {
      for (var user in querySnapshot.docs) {
        if (userCode == user.id) {
          isPresent = true;
          break;
        }
      }

      if (isPresent == false) {
        userData.doc(userCode).set(demodata);
      }
    });

    userData.snapshots().listen((snapshot) {});
    var docSnapshot = await userData.doc(userCode).get();
    totalEmission = double.parse(docSnapshot.get("Emission").toString());
    setState(() {});
  }
}
