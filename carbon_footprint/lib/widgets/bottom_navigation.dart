import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/widgets/navigate_button.dart';
import 'package:flutter/material.dart';

class MyButtomNavigationBar extends StatefulWidget {
  const MyButtomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyButtomNavigationBarState createState() => _MyButtomNavigationBarState();
}

class _MyButtomNavigationBarState extends State<MyButtomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      height: MediaQuery.of(context).size.height / 10,
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
                offset: const Offset(3, -8),
                spreadRadius: 1,
                blurRadius: 8),
            BoxShadow(
                color: Colors.white.withOpacity(0.4),
                offset: const Offset(1, -7),
                spreadRadius: -2,
                blurRadius: 20),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavigateButton(
            nextPage: () {
              //TODO: navigate button 1
            },
            iconData: Icons.home,
            tag: 1,
            selectedIndex: _selectedIndex,
          ),
          NavigateButton(
            nextPage: () {
              //TODO: navigate button 2
            },
            iconData: Icons.markunread,
            tag: 2,
            selectedIndex: _selectedIndex,
          ),
          NavigateButton(
            nextPage: () {
              //TODO: navigate button 3
            },
            iconData: Icons.person,
            tag: 3,
            selectedIndex: _selectedIndex,
          ),
        ],
      ),
    );
  }
}
