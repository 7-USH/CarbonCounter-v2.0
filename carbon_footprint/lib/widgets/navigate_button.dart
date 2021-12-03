// ignore_for_file: must_be_immutable
import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';

class NavigateButton extends StatefulWidget {
  NavigateButton(
      {Key? key,
      required this.iconData,
      required this.nextPage,
      required this.tag,
      required this.selectedIndex})
      : super(key: key);
  int tag;
  int selectedIndex;
  Function nextPage;
  IconData iconData;

  @override
  _NavigateButtonState createState() => _NavigateButtonState();
}

class _NavigateButtonState extends State<NavigateButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectedIndex = widget.tag;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            widget.selectedIndex = 1;
          });
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.height / 7,
        decoration:
            BoxDecoration(color: kGreenOne, shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.19),
              offset: const Offset(0.5, 8),
              spreadRadius: 1,
              blurRadius: 8),
          BoxShadow(
              color: Colors.white.withOpacity(0.4),
              offset: const Offset(-3, -7),
              spreadRadius: -2,
              blurRadius: 20),
        ]),
        child: Center(
          child: Icon(
            widget.iconData,
            color: widget.selectedIndex == widget.tag
                ? kPrimeColor
                : Colors.white.withOpacity(0.95),
            size: 40,
          ),
        ),
      ),
    );
  }
}
