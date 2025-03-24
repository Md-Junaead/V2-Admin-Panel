import 'dart:convert';
import 'package:admin_panel/screens/dashboard/loan/loan_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Renamed to LoanProvider for consistency with import path
class LoanProvider with ChangeNotifier {
  // Updated: Changed from LoanDataProvider to LoanProvider
  List<LoanModel> _loans =
      []; // Updated: Changed Loan to LoanModel to match the model class
  bool _isLoading = true;
  String _errorMessage = '';
  String _searchQuery = '';
  String _sortOption = 'New';

  List<LoanModel> get loans => _loans; // Updated: Changed Loan to LoanModel
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get sortOption => _sortOption;

  // Fetch loan data from the API
  Future<void> fetchLoanData() async {
    final url =
        'http://108.181.173.121:6160/api/loan/get'; // Updated: Removed extra space from original 'http://108.181.173.121:6160/ api/loan/get'

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _loans = data
            .map((loan) => LoanModel.fromJson(loan))
            .toList(); // Updated: Changed Loan.fromJson to LoanModel.fromJson
        _isLoading = false;
        notifyListeners();
      } else {
        // Error message from the API response
        _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
        _isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'Error fetching data: $error';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search functionality
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Sorting functionality
  void updateSortOption(String option) {
    _sortOption = option;
    _loans.sort((a, b) {
      if (option == 'New') {
        return b.requestdate
            .compareTo(a.requestdate); // Sort by date descending
      } else {
        return a.requestdate.compareTo(b.requestdate); // Sort by date ascending
      }
    });
    notifyListeners();
  }

  // Helper function to format the date to Day/Month/Year
  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date); // Parse the date from string
      return "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}"; // Format as Day/Month/Year
    } catch (e) {
      return date; // Return the original date if parsing fails
    }
  }
}
