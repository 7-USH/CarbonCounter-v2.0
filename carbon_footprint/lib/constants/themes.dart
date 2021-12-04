import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimeColor = Color(0xff005A62);
const Color kSecondaryColor = Color(0xff188E68);
const Color kGreenOne = Color(0xff3AB29C);
const Color kGreenTwo = Color(0xff41CD8C);
const Color kTextColor = Color(0xff1A2A36);

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white.withOpacity(0.95),
  textTheme: TextTheme(
    headline1: GoogleFonts.lobsterTwo(
        color: kTextColor, fontSize: 50, fontWeight: FontWeight.w300),
    headline2: GoogleFonts.ptSerif(
        color: kTextColor, fontSize: 40, fontWeight: FontWeight.bold),
    headline3: GoogleFonts.lobster(color: kTextColor, fontSize: 34),
    headline6: GoogleFonts.ptSerif(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 45,
    ),
    bodyText1: GoogleFonts.ptSerif(
        color: kTextColor.withOpacity(0.8),
        fontSize: 15,
        fontWeight: FontWeight.bold),
    bodyText2: GoogleFonts.notoSans(
      color: kTextColor,
      fontSize: 20,
    ),
    subtitle1: GoogleFonts.firaSans(
      color: Colors.white,
      fontSize: 20,
    ),
    subtitle2: GoogleFonts.ptSerif(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    headline4: GoogleFonts.ptSerif(
        color: kPrimeColor.withOpacity(0.9),
        fontSize: 30,
        fontWeight: FontWeight.bold),
    headline5: GoogleFonts.ptSerif(
        color: kTextColor, fontSize: 25, fontWeight: FontWeight.bold),
    button: GoogleFonts.notoSans(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
  ),
);
