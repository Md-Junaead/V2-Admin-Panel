//loan.dart
import 'package:admin_panel/screens/dashboard/loan/loan_table.dart';
import 'package:flutter/material.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: LoanTable(), // Integrate LoanTableScreen here
          ),
        ],
      ),
    );
  }
}
