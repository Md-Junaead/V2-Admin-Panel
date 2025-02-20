// // nominee_screen.dart
// import 'package:flutter/material.dart';
// import 'nominee_model.dart';
// import 'nominee_service.dart';

// class NomineeScreen extends StatefulWidget {
//   @override
//   _NomineeScreenState createState() => _NomineeScreenState();
// }

// class _NomineeScreenState extends State<NomineeScreen> {
//   late Future<List<Nominee>> _nominees;

//   @override
//   void initState() {
//     super.initState();
//     _nominees = NomineeService().fetchNominees();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Nominees')),
//       body: FutureBuilder<List<Nominee>>(
//         future: _nominees,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No nominees found'));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final nominee = snapshot.data![index];
//               final user = nominee.user;
//               return Card(
//                 margin: EdgeInsets.all(8.0),
//                 child: ListTile(
//                   title: Text(nominee.name),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 8.0),
//                       Text('User Details:'),
//                       Text('Name: ${user.name}'),
//                       Text('Email: ${user.email}'),
//                       Text('Phone: ${user.phoneNo}'),
//                       Text('Address: ${user.address}'),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



// // nominee_service.dart
// import 'dart:convert';
// import 'package:admin_panel/screens/nominee/nominee_model.dart';
// import 'package:http/http.dart' as http;

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



// // nominee_model.dart
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
//   final String userid;
//   final String password;
//   final String name;
//   final String email;
//   final String phoneNo;
//   final DateTime dob;
//   final String address;
//   final String country;
//   final String image;
//   final String referralCode;

//   User({
//     required this.id,
//     required this.userid,
//     required this.password,
//     required this.name,
//     required this.email,
//     required this.phoneNo,
//     required this.dob,
//     required this.address,
//     required this.country,
//     required this.image,
//     required this.referralCode,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       userid: json['userid'],
//       password: json['password'],
//       name: json['name'],
//       email: json['email'],
//       phoneNo: json['phoneNo'],
//       dob: DateTime.parse(json['dob']),
//       address: json['address'],
//       country: json['country'],
//       image: json['image'],
//       referralCode: json['referralCode'],
//     );
//   }
// }
