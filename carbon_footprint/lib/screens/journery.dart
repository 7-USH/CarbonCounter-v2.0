import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';

class JourneyCounter extends StatefulWidget {
  JourneyCounter({Key? key}) : super(key: key);
  static String id = "journey";

  @override
  _JourneyCounterState createState() => _JourneyCounterState();
}

class _JourneyCounterState extends State<JourneyCounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo])),
      ),
    );
  }
}
