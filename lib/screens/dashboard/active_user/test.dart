// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'nominee_view_model.dart';

// class AllUser extends StatelessWidget {
//   const AllUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => NomineeViewModel()..fetchNominees(),
//       child: Scaffold(
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             double width = constraints.maxWidth;
//             int flexValue =
//                 width > 1200 ? 8 : 12; // Adjust flex for large screens
//             return Row(
//               children: [
//                 Expanded(
//                   flex: flexValue,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 20),
//                       const Text(
//                         "This is all User Screen",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       Expanded(
//                         child: Consumer<NomineeViewModel>(
//                           builder: (context, viewModel, child) {
//                             if (viewModel.isLoading) {
//                               return const Center(
//                                   child: CircularProgressIndicator());
//                             } else if (viewModel.errorMessage.isNotEmpty) {
//                               return Center(
//                                   child: Text(viewModel.errorMessage));
//                             } else if (viewModel.nominees.isEmpty) {
//                               return const Center(
//                                   child: Text('No nominees found'));
//                             }
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: DataTable(
//                                   columns: const [
//                                     DataColumn(label: Text('Name')),
//                                     DataColumn(label: Text('Email')),
//                                     DataColumn(label: Text('Phone')),
//                                     DataColumn(label: Text('Address')),
//                                     DataColumn(label: Text('Nominee')),
//                                   ],
//                                   rows: viewModel.nominees.map((nominee) {
//                                     return DataRow(cells: [
//                                       DataCell(Text(nominee.user.name)),
//                                       DataCell(Text(nominee.user.email)),
//                                       DataCell(Text(nominee.user.phoneNo)),
//                                       DataCell(Text(nominee.user.address)),
//                                       DataCell(Text(nominee.name)),
//                                     ]);
//                                   }).toList(),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => context.read<NomineeViewModel>().fetchNominees(),
//           child: Icon(Icons.refresh),
//         ),
//       ),
//     );
//   }
// }

// // nominee_model.dart (Model)
// class Nominee {
//   final int id;
//   final String name;
//   final String email;
//   final String cellNo;
//   final DateTime dob;
//   final String relationship;
//   final User user;

//   Nominee({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.cellNo,
//     required this.dob,
//     required this.relationship,
//     required this.user,
//   });

//   factory Nominee.fromJson(Map<String, dynamic> json) {
//     return Nominee(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       cellNo: json['cellNo'],
//       dob: DateTime.parse(json['dob']),
//       relationship: json['relationship'],
//       user: User.fromJson(json['user']),
//     );
//   }
// }

// class User {
//   final int id;
//   final String name;
//   final String email;
//   final String phoneNo;
//   final String address;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phoneNo,
//     required this.address,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       phoneNo: json['phoneNo'],
//       address: json['address'],
//     );
//   }
// }






// // nominee_service.dart (Service)
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'nominee_model.dart';

// class NomineeService {
//   static const String url = 'http://84.247.161.200:9090/api/nominee/getAll';

//   Future<List<Nominee>> fetchNominees() async {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Nominee.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load nominees');
//     }
//   }
// }



// // nominee_view_model.dart (ViewModel)
// import 'package:flutter/material.dart';
// import 'nominee_service.dart';
// import 'nominee_model.dart';

// class NomineeViewModel extends ChangeNotifier {
//   final NomineeService _service = NomineeService();
//   List<Nominee> _nominees = [];
//   bool _isLoading = false;
//   String _errorMessage = '';

//   List<Nominee> get nominees => _nominees;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;

//   Future<void> fetchNominees() async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners();

//     try {
//       _nominees = await _service.fetchNominees();
//     } catch (e) {
//       _errorMessage = 'Failed to load nominees';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
