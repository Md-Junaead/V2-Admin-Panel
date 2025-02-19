import 'package:admin_panel/views/sidebar_view.dart';
import 'package:flutter/material.dart';

class Deposit extends StatelessWidget {
  const Deposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(flex: 2, child: SidebarView()),
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                "Current Selected Menu: Deposit",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ), // Main content area
        ],
      ),
    );
  }
}
