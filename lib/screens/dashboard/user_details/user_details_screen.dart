import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final String userid;
  final String name;
  final String email;
  final String phoneNo;
  final String address;
  final String country;
  final DateTime? dob;
  final String? nidnumber;
  final String? passport;

  const UserDetailScreen({
    super.key,
    required this.userid,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.country,
    this.dob,
    this.nidnumber,
    this.passport,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildUserDetailRow('User ID:', userid),
            _buildUserDetailRow('Name:', name),
            _buildUserDetailRow('Email:', email),
            _buildUserDetailRow('Phone No:', phoneNo),
            _buildUserDetailRow('Address:', address),
            _buildUserDetailRow('Country:', country),
            // Add more details if needed
          ],
        ),
      ),
    );
  }

  // Helper method to build user details rows
  Widget _buildUserDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label ', // Label for the detail
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value, // Displaying the value for each detail
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
