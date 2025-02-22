import 'package:admin_panel/screens/dashboard/deposit/deposit_model.dart';
import 'package:admin_panel/screens/dashboard/deposit/deposit_service.dart';
import 'package:flutter/material.dart';

class BalanceViewModel extends ChangeNotifier {
  List<BalanceModel> _balances = [];
  bool _isLoading = false;
  String _errorMessage = "";

  List<BalanceModel> get balances => _balances;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final BalanceService _balanceService = BalanceService();

  Future<void> loadBalances() async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      _balances = await _balanceService.fetchBalances();
    } catch (e) {
      _errorMessage = "Error loading data: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
