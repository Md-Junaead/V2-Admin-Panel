// class LoanModel {
//   final int id;
//   final double eligibleBalance;
//   final double loanAmount;
//   final double weeklyPay;
//   final double totalPay;
//   final int tenure;
//   final String status;
//   final String requestDate;
//   final UserRegistration userRegistration;

//   LoanModel({
//     required this.id,
//     required this.eligibleBalance,
//     required this.loanAmount,
//     required this.weeklyPay,
//     required this.totalPay,
//     required this.tenure,
//     required this.status,
//     required this.requestDate,
//     required this.userRegistration,
//   });

//   factory LoanModel.fromJson(Map<String, dynamic> json) {
//     return LoanModel(
//       id: json['id'],
//       eligibleBalance: (json['eligeblebalancey'] is int
//           ? (json['eligeblebalancey'] as int).toDouble()
//           : json['eligeblebalancey']),
//       loanAmount: (json['loanamuont'] is int
//           ? (json['loanamuont'] as int).toDouble()
//           : json['loanamuont']),
//       weeklyPay: (json['weeklypay'] is int
//           ? (json['weeklypay'] as int).toDouble()
//           : json['weeklypay']),
//       totalPay: (json['totalpay'] is int
//           ? (json['totalpay'] as int).toDouble()
//           : json['totalpay']),
//       tenure: json['tenure'],
//       status: json['status'],
//       requestDate: json['requestdate'],
//       userRegistration: UserRegistration.fromJson(json['userRegistration']),
//     );
//   }
// }

// class UserRegistration {
//   final String name;
//   final String email;
//   final String phoneNo;

//   UserRegistration({
//     required this.name,
//     required this.email,
//     required this.phoneNo,
//   });

//   factory UserRegistration.fromJson(Map<String, dynamic> json) {
//     return UserRegistration(
//       name: json['name'],
//       email: json['email'],
//       phoneNo: json['phoneNo'],
//     );
//   }
// }



// //loan.dart
// import 'package:admin_panel/screens/dashboard/loan/loan_table.dart';
// import 'package:flutter/material.dart';

// class LoanScreen extends StatelessWidget {
//   const LoanScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Loan'),
//         centerTitle: true,
//       ),
//       body: Row(
//         children: [
//           Expanded(
//             flex: 8,
//             child: LoanTable(), // Integrate LoanTableScreen here
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'dart:convert';

// import 'package:admin_panel/screens/dashboard/loan/loan_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// // LoanDataProvider to manage state
// class LoanDataProvider with ChangeNotifier {
//   List<LoanModel> _loans = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//   String _searchQuery = '';
//   String _sortOption = 'New';

//   List<LoanModel> get loans => _loans;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;
//   String get searchQuery => _searchQuery;
//   String get sortOption => _sortOption;

//   // Fetch loan data from the API
//   Future<void> fetchLoanData() async {
//     final url = 'http://84.247.161.200:9090/api/loan/all';

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         _loans = data.map((loan) => LoanModel.fromJson(loan)).toList();
//         _isLoading = false;
//         notifyListeners();
//       } else {
//         // Error message from the API response
//         _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
//         _isLoading = false;
//         notifyListeners();
//       }
//     } catch (error) {
//       _errorMessage = 'Error fetching data: $error';
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Search functionality
//   void updateSearchQuery(String query) {
//     _searchQuery = query;
//     notifyListeners();
//   }

//   // Sorting functionality
//   void updateSortOption(String option) {
//     _sortOption = option;
//     _loans.sort((a, b) {
//       if (option == 'New') {
//         return b.requestDate.compareTo(a.requestDate);
//       } else {
//         return a.requestDate.compareTo(b.requestDate);
//       }
//     });
//     notifyListeners();
//   }

//   // Helper function to format the date to Day/Month/Year
//   String formatDate(String date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date); // Parse the date from string
//       return "${parsedDate.day.toString().padLeft(2, '0')}/${(parsedDate.month).toString().padLeft(2, '0')}/${parsedDate.year}"; // Format as Day/Month/Year
//     } catch (e) {
//       return date; // Return the original date if parsing fails
//     }
//   }
// }

// class LoanTable extends StatefulWidget {
//   const LoanTable({super.key});

//   @override
//   _LoanTableState createState() => _LoanTableState();
// }

// class _LoanTableState extends State<LoanTable> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch loan data when screen initializes
//     Provider.of<LoanDataProvider>(context, listen: false).fetchLoanData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<LoanDataProvider>(
//         builder: (context, loanDataProvider, child) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: loanDataProvider.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : loanDataProvider.errorMessage.isNotEmpty
//                     ? Center(child: Text(loanDataProvider.errorMessage))
//                     : Column(
//                         children: [
//                           // Table header
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Loan Table',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25,
//                                 ),
//                               ),
//                               // Search option
//                               SizedBox(
//                                 width: 300,
//                                 child: TextField(
//                                   onChanged: (value) {
//                                     loanDataProvider.updateSearchQuery(value);
//                                   },
//                                   decoration: InputDecoration(
//                                     hintText: 'Search by UserID or Name',
//                                     border: OutlineInputBorder(),
//                                     prefixIcon: Icon(Icons.search),
//                                   ),
//                                 ),
//                               ),
//                               // Sorting option
//                               DropdownButton<String>(
//                                 value: loanDataProvider.sortOption,
//                                 onChanged: (value) {
//                                   if (value != null) {
//                                     loanDataProvider.updateSortOption(value);
//                                   }
//                                 },
//                                 items: const [
//                                   DropdownMenuItem(
//                                     value: 'New',
//                                     child: Text('New'),
//                                   ),
//                                   DropdownMenuItem(
//                                     value: 'Old',
//                                     child: Text('Old'),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           // Loan table
//                           Expanded(
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: DataTable(
//                                 columns: const [
//                                   DataColumn(label: Text('Loan ID')),
//                                   DataColumn(label: Text('Name')),
//                                   DataColumn(label: Text('Loan Amount')),
//                                   DataColumn(label: Text('Weekly Pay')),
//                                   DataColumn(label: Text('Total Pay')),
//                                   DataColumn(label: Text('Tenure')),
//                                   DataColumn(label: Text('Status')),
//                                   DataColumn(label: Text('Request Date')),
//                                 ],
//                                 rows: loanDataProvider.loans
//                                     .where((loan) =>
//                                         loan.userRegistration.name
//                                             .toLowerCase()
//                                             .contains(loanDataProvider
//                                                 .searchQuery
//                                                 .toLowerCase()) ||
//                                         loan.id.toString().contains(
//                                             loanDataProvider.searchQuery))
//                                     .map((loan) {
//                                   return DataRow(cells: [
//                                     DataCell(Text(loan.id.toString())),
//                                     DataCell(Text(loan.userRegistration.name)),
//                                     DataCell(Text(loan.loanAmount.toString())),
//                                     DataCell(Text(
//                                         loan.weeklyPay.toStringAsFixed(2))),
//                                     DataCell(
//                                         Text(loan.totalPay.toStringAsFixed(2))),
//                                     DataCell(Text(loan.tenure.toString())),
//                                     DataCell(Text(loan.status)),
//                                     DataCell(Text(loanDataProvider
//                                         .formatDate(loan.requestDate))),
//                                   ]);
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Refresh the loan data when pressed
//           Provider.of<LoanDataProvider>(context, listen: false).fetchLoanData();
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
