import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'deposit_model.dart';

class DepositViewModel extends ChangeNotifier {
  // List to hold deposit data
  List<DepositModel> _balances = [];
  List<DepositModel> _filteredBalances = [];
  bool _isLoading = false;

  // Getter for the balance list
  List<DepositModel> get balances =>
      _filteredBalances.isEmpty ? _balances : _filteredBalances;

  // Getter for the loading state
  bool get isLoading => _isLoading;

  // Method to fetch balance data from API
  Future<void> fetchBalances() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://84.247.161.200:9090/api/Balance/get');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Parse the JSON response and convert it to a list of DepositModel
        List<dynamic> data = json.decode(response.body);
        _balances = data.map((json) => DepositModel.fromJson(json)).toList();
        _filteredBalances = _balances; // Initially, no filters applied
      }
    } catch (e) {
      print('Error fetching balances: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  // Method to search balances by UserID or Name
  void searchBalances(String query) {
    _filteredBalances = _balances
        .where((balance) =>
            balance.userId.toLowerCase().contains(query.toLowerCase()) ||
            balance.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // Method to sort balances by a specific field
  void sortBalances(String option) {
    switch (option) {
      case 'New':
        // Sorting by the newest entry (ID descending)
        _balances.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 'Old':
        // Sorting by the oldest entry (ID ascending)
        _balances.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 'Name':
        // Sorting by Name alphabetically
        _balances.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Country':
        // Sorting by Country alphabetically
        _balances.sort((a, b) => a.country.compareTo(b.country));
        break;
      default:
        break;
    }
    // Apply the sorted list to filteredBalances as well
    _filteredBalances = _balances; // Reset filtered list after sorting
    notifyListeners();
  }
}
