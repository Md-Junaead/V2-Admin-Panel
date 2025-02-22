// ViewModel: deposit_view_model.dart
import 'package:admin_panel/screens/deposit/deposit_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DepositViewModel extends ChangeNotifier {
  List<DepositModel> _balances = [];
  bool _isLoading = false;

  List<DepositModel> get balances => _balances;
  bool get isLoading => _isLoading;

  Future<void> fetchBalances() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://84.247.161.200:9090/api/Balance/get');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _balances = data.map((json) => DepositModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching balances: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
