// ignore_for_file: prefer_const_constructors
//Page after first page to navigate to the home page if logged in else navigate to the login page

import 'package:carbon_footprint/screens/home_screen.dart';
import 'package:carbon_footprint/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  static String id = "GoogleValidate";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              return Center(child: Text("Oops! Something went wrong."));
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
