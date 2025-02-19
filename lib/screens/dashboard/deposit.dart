import 'package:flutter/material.dart';

class Deposit extends StatelessWidget {
  const Deposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                "This is Deposit Screen",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ), // Main content area
        ],
      ),
    );
  }
}
