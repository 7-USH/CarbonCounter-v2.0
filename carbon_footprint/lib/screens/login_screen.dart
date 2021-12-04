import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/screens/provider/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  static String id = "LoginScreen";
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimeColor, kGreenTwo],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topCenter),
              ),
              height: size.height / 2,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    "Welcome to",
                    style: TextStyle(
                        fontFamily: GoogleFonts.ruda().fontFamily,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(207, 255, 214, 1)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(08),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    "Carbon Counter!",
                    style: TextStyle(
                        fontFamily: GoogleFonts.ruda().fontFamily,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(207, 255, 214, 1)),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontFamily: GoogleFonts.ruda().fontFamily,
                      fontSize: 54,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          fixedSize:
                              MaterialStateProperty.all(const Size(200, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        },
                        child: Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.google,
                              size: 20,
                              color: kGreenOne,
                            ),
                            Text(
                              "    Sign-In using Google",
                              style: TextStyle(
                                  color: kGreenOne,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height - 100); //start path
    var firstStart = Offset(size.width / 5, size.height + 50);
    //  first point of the curve
    var firstEnd = Offset(size.width, size.height - 90);
    //  second point of the curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
