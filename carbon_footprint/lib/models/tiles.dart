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
          color: Colors.orange,
          emission: 45,
          sentence: "Transport",
          icon: Icons.place_outlined),
      Tiles(
          color: Colors.red,
          emission: 80,
          sentence: "Meals",
          icon: Icons.food_bank),
    ];
  }
}
