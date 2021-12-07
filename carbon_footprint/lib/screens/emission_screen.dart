// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/models/tiles.dart';
import 'package:carbon_footprint/screens/journery.dart';
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
  bool _onCreatePage = false;

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
    double pinVisible = size.height / 8;
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
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Stack(
                children: [
                  Container(
                    height: size.height / 6,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Journey Time",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          "How much time did you travel on this day?",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                  AnimatedPadding(
                    curve: Curves.easeIn,
                    duration: Duration(seconds: 1),
                    padding: EdgeInsets.only(
                        top: _onCreatePage ? pinVisible : pinInvisible),
                    child: Container(
                      height: size.height * 4 / 6.5,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                offset: const Offset(5, 7),
                                spreadRadius: 1,
                                blurRadius: 8),
                          ]),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class EmissionBottomBar extends StatelessWidget {
  const EmissionBottomBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.only(bottom: 15, top: 10),
        height: size.height / 10,
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
            ]),
        child: Center(
          child: GestureDetector(
            onTap: () {
              // TODO: next Page Map
              Navigator.pushNamed(context, JourneyCounter.id);
            },
            onTapDown: (details) => {},
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withOpacity(0.95),
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

class TransportList extends StatefulWidget {
  TransportList({Key? key}) : super(key: key);

  @override
  _TransportListState createState() => _TransportListState();
}

class _TransportListState extends State<TransportList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: Utils.getEmissionTiles().length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.black,
          height: 200,
          width: 200,
        );
      },
    );
  }
}
