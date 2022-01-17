// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen(
      {Key? key,
      this.caption = "Carbon Counter",
      required this.nextPage,
      this.duration = 3})
      : super(key: key);
  static String id = "LoadingScreen";
  Widget nextPage;
  int duration;

  String caption;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: widget.duration), () {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => widget.nextPage),ModalRoute.withName(HomeScreen.id));
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/bg_carbon.png"),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.caption,
                style: appTheme.textTheme.headline1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
