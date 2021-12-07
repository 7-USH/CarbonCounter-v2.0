// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InfoTiles extends StatelessWidget {
  double percent;
  String text;
  Color color;
  IconData icon;
  InfoTiles(
      {Key? key,
      required this.color,
      required this.icon,
      required this.text,
      required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textPercent = percent.toInt();
    final barPercent = percent / 100;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [kPrimeColor, kSecondaryColor]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(1,4),
              spreadRadius: 1,
              blurRadius: 8),
          // BoxShadow(
          //     color: Colors.white.withOpacity(0.4),
          //     offset: const Offset(-1, -10),
          //     spreadRadius: -2,
          //     blurRadius: 20),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          myContainer(height: size.height / 10, color: color, icon: icon),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: text + "  ",
                        style: Theme.of(context).textTheme.subtitle1),
                    TextSpan(
                        text: "$textPercent%",
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
              ),
              LinearPercentIndicator(
                linearGradient: LinearGradient(
                  colors: [
                    kGreenOne,
                    color,
                  ],
                ),
                lineHeight: 10,
                width: size.width / 2,
                backgroundColor: Colors.white,
                percent: barPercent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget myContainer(
    {required height, required Color color, required IconData icon}) {
  return Container(
    height: height,
    width: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(
      icon,
      size: 50,
      color: Colors.white,
    ),
  );
}
