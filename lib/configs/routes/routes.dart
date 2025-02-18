import 'package:admin_panel/configs/routes/routes_name.dart';
import 'package:admin_panel/screens/dashboard/dashboard_view.dart';
import 'package:admin_panel/views/sidebar_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.sidebarView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SidebarView());

      case RoutesName.dashboardView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
