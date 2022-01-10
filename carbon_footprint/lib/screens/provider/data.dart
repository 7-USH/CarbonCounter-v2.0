import 'package:flutter/material.dart';

class DataPage extends ChangeNotifier {
  int selectedIndex = 0;

  getIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
