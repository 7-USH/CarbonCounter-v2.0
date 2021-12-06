// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';


class EmissionPage extends StatefulWidget {
  EmissionPage({Key? key}) : super(key: key);

  @override
  _EmissionPageState createState() => _EmissionPageState();
}

class _EmissionPageState extends State<EmissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       decoration: BoxDecoration(
         gradient:LinearGradient(
           colors:[
             kPrimeColor,
             kGreenOne
           ] )
       ),
     ), 
    );
  }
}