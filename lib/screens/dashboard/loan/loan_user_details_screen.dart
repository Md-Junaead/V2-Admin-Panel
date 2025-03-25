import 'package:admin_panel/view/sidebar_view.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_model.dart'; // Import the LoanModel

class LoanUserDetailScreen extends StatelessWidget {
  final LoanModel loan;

  const LoanUserDetailScreen({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // updated line: add Row to include sidebar and content
        children: [
          const Expanded(
              flex: 2,
              child:
                  SidebarView()), // updated line: include SidebarView on left side
          Expanded(
            flex: 8,
            child: Scaffold(
              // updated line: wrap content in an inner Scaffold
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
                    Text('User  Details:', style: _headerTextStyle),
                    const SizedBox(height: 8),
                    Text('User  ID: ${loan.userRegistration.userid}',
                        style: _detailTextStyle),
                    Text('Name: ${loan.userRegistration.name}',
                        style: _detailTextStyle),
                    Text('Email: ${loan.userRegistration.email}',
                        style: _detailTextStyle),
                    const SizedBox(height: 16),
                    Text('Eligible Balance: ${loan.eligeblebalancey}',
                        style: _detailTextStyle),
                    const SizedBox(height: 8),
                    Text('Loan Amount: ${loan.loanamuont}',
                        style: _detailTextStyle),
                    const SizedBox(height: 8),
                    Text('Weekly Pay: ${loan.weeklypay}',
                        style: _detailTextStyle),
                    const SizedBox(height: 8),
                    Text('Total Pay: ${loan.totalpay}',
                        style: _detailTextStyle),
                    const SizedBox(height: 8),
                    Text('Tenure: ${loan.tenure}', style: _detailTextStyle),
                    const SizedBox(height: 8),
                    Text('Status: ${loan.status}', style: _detailTextStyle),
                    const SizedBox(height: 8),
                    Text('Request Date: ${loan.requestdate.toIso8601String()}',
                        style: _detailTextStyle),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle _detailTextStyle = TextStyle(fontSize: 16);
  static const TextStyle _headerTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}
