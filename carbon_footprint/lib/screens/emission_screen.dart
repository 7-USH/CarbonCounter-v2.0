// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/screens/login_screen.dart';
import 'package:carbon_footprint/screens/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmissionPage extends StatefulWidget {
  EmissionPage({Key? key}) : super(key: key);

  @override
  _EmissionPageState createState() => _EmissionPageState();
}

class _EmissionPageState extends State<EmissionPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Container(
        height: size.height/10,

      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new)),
          ),
          body:Padding(
            padding: const EdgeInsets.only(left:20.0,right: 20.0),
            child: Stack(
              children: [
                Container(
                  height: size.height/6,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Journey Time",
                      style: Theme.of(context).textTheme.headline3,),
                      Text("How much time did you travel on this day?",
                      style: Theme.of(context).textTheme.bodyText2,)
                    ],
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height/6,
                        ),
                        Container(
                          height: size.height*4/6,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                          BoxShadow(
                         color: Colors.black.withOpacity(0.19),
                          offset: const Offset(5, 7),
                          spreadRadius: 1,
                            blurRadius: 8),
                            ]
                          ),
                        ),
                         SizedBox(
                            height: size.height / 10,
                          ), 
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
