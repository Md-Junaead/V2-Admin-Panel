// loan_table.dart
import 'dart:convert';

import 'package:admin_panel/screens/dashboard/loan/loan_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoanTable extends StatefulWidget {
  const LoanTable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoanTableState createState() => _LoanTableState();
}

class _LoanTableState extends State<LoanTable> {
  List<LoanModel> _loans = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchLoanData();
  }

  // Fetch loan data from the API
  Future<void> fetchLoanData() async {
    final url = 'http://84.247.161.200:9090/api/loan/all';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _loans = data.map((loan) => LoanModel.fromJson(loan)).toList();
          _isLoading = false;
        });
      } else {
        // Error message from the API response
        setState(() {
          _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching data: $error';
        _isLoading = false;
      });
    }
  }

  // Helper function to format the date to Day/Month/Year
  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date); // Parse the date from string
      return "${parsedDate.day.toString().padLeft(2, '0')}/${(parsedDate.month).toString().padLeft(2, '0')}/${parsedDate.year}"; // Format as Day/Month/Year
    } catch (e) {
      return date; // Return the original date if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis
                          .horizontal, // Make the table scrollable horizontally
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Loan ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Loan Amount')),
                          DataColumn(label: Text('Weekly Pay')),
                          DataColumn(label: Text('Total Pay')),
                          DataColumn(label: Text('Tenure')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Request Date')),
                        ],
                        rows: _loans.map((loan) {
                          return DataRow(cells: [
                            DataCell(Text(loan.id.toString())),
                            DataCell(Text(loan.userRegistration.name)),
                            DataCell(Text(loan.loanAmount.toString())),
                            DataCell(Text(loan.weeklyPay.toStringAsFixed(2))),
                            DataCell(Text(loan.totalPay.toStringAsFixed(2))),
                            DataCell(Text(loan.tenure.toString())),
                            DataCell(Text(loan.status)),
                            DataCell(Text(formatDate(loan
                                .requestDate))), // Applying the date format here
                          ]);
                        }).toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
