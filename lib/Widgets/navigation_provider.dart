import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    if (index >= 0 && index < 4) { // Ensure index is within valid range
      _selectedIndex = index;
      notifyListeners();
    }
  }
}


