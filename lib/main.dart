import 'package:admin_panel/configs/routes/routes.dart';
import 'package:admin_panel/configs/routes/routes_name.dart';
import 'package:admin_panel/view_models/sidebar_view_model.dart';
import 'package:admin_panel/views/sidebar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AdminPanel());
}

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SidebarViewModel(),
      child: MaterialApp(
        title: "Admin Panel",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Row(
            children: const [
              Expanded(flex: 2, child: SidebarView()),
              Expanded(flex: 8, child: Placeholder()), // Main content area
            ],
          ),
        ),
        // this is the initial route indicating from where our app will start
        initialRoute: RoutesName.dashboardView,
        onGenerateRoute: Routes.generateRoute, // Name of Open screen
      ),
    );
  }
}
