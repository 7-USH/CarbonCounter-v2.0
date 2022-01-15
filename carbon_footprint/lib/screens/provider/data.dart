import 'package:flutter/material.dart';

class DataPage extends ChangeNotifier {
  int selectedIndex = 0;
  String fuelType = "";
  String carType = "";
  
  getIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  setFuelType(String fuel) {
    fuelType = fuel;
    notifyListeners();
  }

  setCarType(String car) {
    carType = car;
    notifyListeners();
  }

  String getCarType() {
    return carType;
  }

  String getfuelType() {
    return fuelType;
  }
}
