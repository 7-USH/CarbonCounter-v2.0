import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/models/Indicator.dart';
import 'package:carbon_footprint/screens/LoadingScreen.dart';
import 'package:carbon_footprint/screens/home_screen.dart';
import 'package:carbon_footprint/screens/journey.dart';
import 'package:carbon_footprint/screens/login_screen.dart';
import 'package:carbon_footprint/screens/menu/vehicle_size_menu.dart';
import 'package:carbon_footprint/screens/provider/data.dart';
import 'package:carbon_footprint/screens/provider/google_sign_in.dart';
import 'package:carbon_footprint/screens/provider/google_validate.dart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/menu/vehicle_fuel_menu.dart';

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
          create: (_) => DataPage(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: LoadingScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          LoginPage.id: (context) => const LoginPage(),
          UserPage.id: (context) => const UserPage(),
          JourneyCounter.id: (context) => const JourneyCounter(),
          LoadingScreen.id: (context) => LoadingScreen(
                nextPage: const UserPage(),
              ),
          Indicator.id: (context) => Indicator(),
          VehicleSizeMenu.id: (context) => VehicleSizeMenu(),
          VehicleFuelMenu.id: (context) => VehicleFuelMenu(),
        },
      ),
    );
  }
}
