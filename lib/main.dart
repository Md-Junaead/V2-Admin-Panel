import 'package:admin_panel/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/view_models/sidebar_view_model.dart';

void main() => runApp(const AdminPanel());

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the SidebarViewModel for the sidebar
        ChangeNotifierProvider(
          create: (context) => SidebarViewModel(),
        ),
      ],
      child: MaterialApp(
        title: "Admin Panel",
        home: DashboardView(),
      ),
    );
  }
}
