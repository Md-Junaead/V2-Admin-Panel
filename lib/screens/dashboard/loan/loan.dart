import 'package:admin_panel/screens/dashboard/loan/loan_table.dart';
import 'package:flutter/material.dart';

class Loan extends StatelessWidget {
  const Loan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: LoanTableScreen(), // Integrate LoanTableScreen here
          ),
        ],
      ),
    );
  }
}
