import 'package:admin_panel/screens/dashboard/active_user/nominee_view_model.dart';
import 'package:admin_panel/screens/dashboard/all_user/reg_user_view_mode.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_table.dart';
import 'package:admin_panel/screens/deposit/deposit_view_model.dart';
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
        ChangeNotifierProvider(
          create: (context) => DepositViewModel()..fetchBalances(),
        ),

        ChangeNotifierProvider(create: (context) => NomineeViewModel()),
        ChangeNotifierProvider(
          create: (context) => RegUserViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => LoanDataProvider()),
      ],
      child: MaterialApp(
        title: "Admin Panel",
        home: DashboardView(),
      ),
    );
  }
}
