// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/models/tiles.dart';
import 'package:carbon_footprint/screens/emission_screen.dart';
import 'package:carbon_footprint/widgets/bottom_navigation.dart';
import 'package:carbon_footprint/widgets/circular_chart.dart';
import 'package:carbon_footprint/widgets/info_tiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();
    String name = user.displayName!;

    String newName = name.split(" ")[0].firstLetterUpperCase();
    
      return Scaffold(
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimeColor, kGreenOne, kGreenTwo])),
            child: const MyButtomNavigationBar()),
        body: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo])),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
                          // Text(
                          //   "Hello, "+name.split(" ")[0].toString(),
                          //   style: Theme.of(context).textTheme.headline3,
                          // ),
                          Flexible(
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child:  RichText(
                                    text: TextSpan(
                                        text: "Hey, ",
                                        style: Theme.of(context).textTheme.headline3,
                                        children: [
                                      TextSpan(
                                          text: newName,
                                          style:
                                              Theme.of(context).textTheme.headline3
                                              ),                           
                                    ])).shimmer(
                                      primaryColor: kTextColor,
                                      secondaryColor: kPrimeColor.withOpacity(0.6)
                                    ),
                              ),
                          ),
                        
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

                  calculationNumber: 100,
                  width: size.width / 3,
                  height: size.height / 3,
                  painter: ProgressPainter(
                      circleWidth: size.width / 17,
                      completedPercentage: 90,
                      defaultCircleColor: Colors.white.withOpacity(0.95),
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
}

Widget myCustomButton(context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return EmissionPage();
      }));
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
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600
    ),
        ).shimmer(
            primaryColor: Colors.white,
            secondaryColor: kPrimeColor,
            duration: const Duration(seconds: 6)),
      ),
    ),
  );
}
