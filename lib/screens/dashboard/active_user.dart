import 'package:flutter/material.dart';

class ActiveUser extends StatelessWidget {
  const ActiveUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                "This is Active User Screen",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ), // Main content area
        ],
      ),
    );
  }
}
