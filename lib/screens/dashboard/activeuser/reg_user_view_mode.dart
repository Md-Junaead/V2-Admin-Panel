import 'package:admin_panel/screens/dashboard/activeuser/reg_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegUserViewModel extends ChangeNotifier {
  List<RegUserModel> _users = [];
  bool _isLoading = false;

  List<RegUserModel> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('http://84.247.161.200:9090/api/microbank/get'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _users = data.map((user) => RegUserModel.fromJson(user)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }
}
