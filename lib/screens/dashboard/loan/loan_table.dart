import 'dart:convert';

import 'package:admin_panel/screens/dashboard/loan/loan_model.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// LoanDataProvider to manage state
class LoanDataProvider with ChangeNotifier {
  List<LoanModel> _loans = [];
  bool _isLoading = true;
  String _errorMessage = '';
  String _searchQuery = '';
  String _sortOption = 'New';

  List<LoanModel> get loans => _loans;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get sortOption => _sortOption;

  // Fetch loan data from the API
  Future<void> fetchLoanData() async {
    final url = 'http://84.247.161.200:9090/api/loan/all';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _loans = data.map((loan) => LoanModel.fromJson(loan)).toList();
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
      return "${parsedDate.day.toString().padLeft(2, '0')}/${(parsedDate.month).toString().padLeft(2, '0')}/${parsedDate.year}"; // Format as Day/Month/Year
    } catch (e) {
      return date; // Return the original date if parsing fails
    }
  }
}

class LoanTable extends StatefulWidget {
  const LoanTable({super.key});

  @override
  _LoanTableState createState() => _LoanTableState();
}

class _LoanTableState extends State<LoanTable> {
  @override
  void initState() {
    super.initState();
    // Fetch loan data when screen initializes
    Provider.of<LoanDataProvider>(context, listen: false).fetchLoanData();
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    String selectedSortOption = 'New';

    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for contrast
      body: Consumer<LoanDataProvider>(
          builder: (context, loanDataProvider, child) {
        return loanDataProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;

                  // Determine layout based on screen size
                  bool isLargeScreen = maxWidth > 1200;
                  bool isMediumScreen = maxWidth > 800 && maxWidth <= 1200;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        // Table Header: Title, Search Bar, Sort Dropdown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Screen Title
                            const Text(
                              'Loan Table',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            // Search Bar
                            Container(
                              width: isLargeScreen
                                  ? 400
                                  : isMediumScreen
                                      ? 300
                                      : 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: '🔍 Search by UserID or Name',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  border: InputBorder.none,
                                ),
                                onChanged: (query) {
                                  loanDataProvider.updateSearchQuery(query);
                                },
                              ),
                            ),
                            // Sort Dropdown
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isLargeScreen ? 16 : 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: DropdownButton<String>(
                                value: selectedSortOption,
                                underline: SizedBox(), // Remove default line
                                items: ['New', 'Old']
                                    .map((option) => DropdownMenuItem(
                                          value: option,
                                          child: Text(option),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  selectedSortOption = value!;
                                  loanDataProvider.updateSortOption(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Data Table with Fixed Header
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: SingleChildScrollView(
                              child: DataTable(
                                columnSpacing: isLargeScreen ? 15 : 10,
                                border: TableBorder.all(color: Colors.black12),
                                headingRowHeight: 50,
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return TColors
                                        .buttonPrimary; // Table header color
                                  },
                                ),
                                columns: const [
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Loan ID',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'UserID',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Name',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Loan Amount',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Weekly Pay',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Total Pay',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Tenure',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                  DataColumn(
                                      label: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Request Date',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  )),
                                ],
                                rows: loanDataProvider.loans
                                    .where((loan) =>
                                        loan.userRegistration.name
                                            .toLowerCase()
                                            .contains(loanDataProvider
                                                .searchQuery
                                                .toLowerCase()) ||
                                        loan.id.toString().contains(
                                            loanDataProvider.searchQuery))
                                    .map((loan) {
                                  return DataRow(cells: [
                                    DataCell(Text(loan.id.toString())),
                                    DataCell(
                                        Text(loan.userRegistration.userid)),
                                    DataCell(Text(loan.userRegistration.name)),
                                    DataCell(Text(loan.loanamuont.toString())),
                                    DataCell(Text(
                                        loan.weeklypay.toStringAsFixed(2))),
                                    DataCell(
                                        Text(loan.totalpay.toStringAsFixed(2))),
                                    DataCell(Text(loan.tenure.toString())),
                                    DataCell(Text(loan.status)),
                                    DataCell(Text(loanDataProvider
                                        .formatDate(loan.requestdate))),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh the loan data when pressed
          Provider.of<LoanDataProvider>(context, listen: false).fetchLoanData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
