import 'package:flutter/material.dart';

class AllUser extends StatelessWidget {
  const AllUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                "This is all users Screen",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ), // Main content area
        ],
      ),
    );
  }
}
