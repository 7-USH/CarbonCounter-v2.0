import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/screens/home_screen.dart';
import 'package:carbon_footprint/screens/journery.dart';
import 'package:carbon_footprint/screens/login_screen.dart';
import 'package:carbon_footprint/screens/provider/data.dart';
import 'package:carbon_footprint/screens/provider/google_sign_in.dart';
import 'package:carbon_footprint/screens/provider/google_validate.dart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (_) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider<DataPage>(
          create:(_)=>DataPage(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: UserPage.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          LoginPage.id: (context) => const LoginPage(),
          UserPage.id: (context) => const UserPage(),
          JourneyCounter.id : (context) => JourneyCounter(),
        },
      ),
    );
  }
}
