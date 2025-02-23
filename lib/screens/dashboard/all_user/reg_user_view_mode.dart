import 'package:admin_panel/screens/dashboard/all_user/reg_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegUserViewModel extends ChangeNotifier {
  List<RegUserModel> _users = [];
  List<RegUserModel> _filteredUsers = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<RegUserModel> get users => _users;
  List<RegUserModel> get filteredUsers => _filteredUsers;
  bool get isLoading => _isLoading;

  // Fetch users from API
  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://84.247.161.200:9090/api/microbank/get'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _users = data.map((user) => RegUserModel.fromJson(user)).toList();
        _filteredUsers = List.from(_users); // Initialize filtered list
      }
    } catch (e) {
      print("Error fetching users: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method to search users (Now includes UserID & Phone Number)
  void searchUsers(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers = _users.where((user) {
        return user.userId.toLowerCase().contains(query.toLowerCase()) ||
            user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()) ||
            user.phoneNo.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // Method to sort users by name, email, or other criteria
  void sortUsers(String sortBy) {
    if (sortBy == 'New') {
      _filteredUsers = List.from(_users); // Keep original order (newest first)
    } else if (sortBy == 'Old') {
      _filteredUsers = List.from(_users.reversed); // Reverse the list
    } else if (sortBy == 'Name') {
      _filteredUsers
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (sortBy == 'Email') {
      _filteredUsers.sort(
          (a, b) => a.email.toLowerCase().compareTo(b.email.toLowerCase()));
    } else if (sortBy == 'Country') {
      _filteredUsers.sort(
          (a, b) => a.country.toLowerCase().compareTo(b.country.toLowerCase()));
    }
    notifyListeners();
  }
}
