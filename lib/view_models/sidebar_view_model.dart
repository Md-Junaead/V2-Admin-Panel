import 'package:flutter/material.dart';

class SidebarViewModel extends ChangeNotifier {
  String _selectedMenu = "Dashboard";

  String get selectedMenu => _selectedMenu;

  void setSelectedMenu(String menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
