// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_import

import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tiles {
  String sentence;
  double emission;
  IconData icon;
  Color color;
  Tiles({
    required this.color,
    required this.emission,
    required this.sentence,
    required this.icon,
  });
}

class EmissionTiles {
  String mode;
  Color color;
  IconData icon;

  EmissionTiles({
    required this.color,
    required this.icon,
    required this.mode,
  });
}

class Utils {
  static List<Tiles> getTiles() {
    return [
      Tiles(
        color: Colors.amber,
        emission: 10,
        sentence: "Total Emission",
        icon: Icons.cloud,
      ),
      Tiles(
        color: Colors.cyan, 
        emission: 45, sentence: 
        "Transport", 
        icon: Icons.airplanemode_on),
      Tiles(
          color: Colors.red,
          emission: 80,
          sentence: "Meals",
          icon: Icons.food_bank),
    ];
  }

  static List<EmissionTiles> getEmissionTiles() {
    return [
      EmissionTiles(color: Colors.red, icon: Icons.ac_unit, mode: "Car"),
      EmissionTiles(color: Colors.yellow, icon: Icons.bus_alert, mode: "Bus"),
      EmissionTiles(color: Colors.blue, icon: Icons.food_bank_outlined, mode: "Meals"),
      EmissionTiles(color: Colors.orange, icon: Icons.place, mode: "Plane"),
      EmissionTiles(color: Colors.green, icon: Icons.air, mode: "Auto"),
      EmissionTiles(color: Colors.teal, icon: Icons.water, mode: "Water")
    ];
  }
}
