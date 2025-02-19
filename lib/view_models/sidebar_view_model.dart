import 'package:flutter/material.dart';

class SidebarViewModel extends ChangeNotifier {
  String _selectedMenu = "Dashboard";
  String _expandedMenu = ""; // Track expanded menu

  String get selectedMenu => _selectedMenu;
  String get expandedMenu => _expandedMenu;

  void setSelectedMenu(String menu) {
    _selectedMenu = menu;
    notifyListeners();
  }

  void toggleMenu(String menu) {
    if (_expandedMenu == menu) {
      _expandedMenu = "";
    } else {
      _expandedMenu = menu;
    }
    notifyListeners();
  }
}
