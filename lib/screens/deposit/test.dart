// // Model: Deposit_model.dart
// class DepositModel {
//   final int id;
//   final double addBalance;
//   final double depositB;
//   final String packages;
//   final double profitB;
//   final double referralB;
//   final double withdrawB;
//   final UserRegistration user;

//   DepositModel({
//     required this.id,
//     required this.addBalance,
//     required this.depositB,
//     required this.packages,
//     required this.profitB,
//     required this.referralB,
//     required this.withdrawB,
//     required this.user,
//   });

//   factory DepositModel.fromJson(Map<String, dynamic> json) {
//     return DepositModel(
//       id: json['id'],
//       addBalance: json['addBalance'].toDouble(),
//       depositB: json['dipositB'].toDouble(),
//       packages: json['packages'],
//       profitB: json['profitB'].toDouble(),
//       referralB: json['referralB'].toDouble(),
//       withdrawB: json['withdrawB'].toDouble(),
//       user: UserRegistration.fromJson(json['userRegistration']),
//     );
//   }
// }

// class UserRegistration {
//   final String name;
//   final String email;
//   final String phoneNo;
//   final String address;
//   final String country;

//   UserRegistration({
//     required this.name,
//     required this.email,
//     required this.phoneNo,
//     required this.address,
//     required this.country,
//   });

//   factory UserRegistration.fromJson(Map<String, dynamic> json) {
//     return UserRegistration(
//       name: json['name'],
//       email: json['email'],
//       phoneNo: json['phoneNo'],
//       address: json['address'],
//       country: json['country'],
//     );
//   }
// }



// // ViewModel: deposit_view_model.dart
// import 'package:admin_panel/screens/deposit/deposit_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DepositViewModel extends ChangeNotifier {
//   List<DepositModel> _balances = [];
//   bool _isLoading = false;

//   List<DepositModel> get balances => _balances;
//   bool get isLoading => _isLoading;

//   Future<void> fetchBalances() async {
//     _isLoading = true;
//     notifyListeners();

//     final url = Uri.parse('http://84.247.161.200:9090/api/Balance/get');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         _balances = data.map((json) => DepositModel.fromJson(json)).toList();
//       }
//     } catch (e) {
//       print('Error fetching balances: $e');
//     }
//     _isLoading = false;
//     notifyListeners();
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:admin_panel/screens/deposit/deposit_view_model.dart';

// class DepositScreen extends StatelessWidget {
//   const DepositScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Check the screen width to adjust layout for responsiveness
//           bool isWideScreen =
//               constraints.maxWidth > 800; // Adjust this threshold as needed

//           return Row(
//             children: [
//               Expanded(
//                 flex: isWideScreen
//                     ? 8
//                     : 12, // Adjust the flex depending on screen size
//                 child: Consumer<DepositViewModel>(
//                   builder: (context, viewModel, child) {
//                     if (viewModel.isLoading) {
//                       return Center(child: CircularProgressIndicator());
//                     }

//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: [
//                           DataColumn(label: Text('ID')),
//                           DataColumn(label: Text('Name')),
//                           DataColumn(label: Text('Balance')),
//                           DataColumn(label: Text('Deposit')),
//                           DataColumn(label: Text('Packages')),
//                           DataColumn(label: Text('Profit')),
//                           DataColumn(label: Text('Referral')),
//                           DataColumn(label: Text('Withdraw')),
//                         ],
//                         rows: viewModel.balances.map((balance) {
//                           return DataRow(
//                             cells: [
//                               DataCell(Text(balance.id.toString())),
//                               DataCell(Text(balance.user.name)),
//                               DataCell(Text(balance.addBalance.toString())),
//                               DataCell(Text(balance.depositB.toString())),
//                               DataCell(Text(balance.packages)),
//                               DataCell(Text(balance.profitB.toString())),
//                               DataCell(Text(balance.referralB.toString())),
//                               DataCell(Text(balance.withdrawB.toString())),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   },
//                 ),
//               ), // Main content area
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => context.read<DepositViewModel>().fetchBalances(),
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }
