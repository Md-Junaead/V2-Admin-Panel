import 'package:flutter/material.dart';

class Loan extends StatelessWidget {
  const Loan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                "This is Loan Screen",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ), // Main content area
        ],
      ),
    );
  }
}
