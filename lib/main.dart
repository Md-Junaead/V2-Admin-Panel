// import 'package:admin_panel/screens/dashboard/active_user/nominee_view_model.dart';
// import 'package:admin_panel/screens/dashboard/all_user/reg_user_view_mode.dart';
// import 'package:admin_panel/screens/dashboard/loan/loan_provider.dart';
// import 'package:admin_panel/screens/dashboard/deposit/deposit_view_model.dart';
// import 'package:admin_panel/screens/login/auth_view_model.dart';
// import 'package:admin_panel/screens/login/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:admin_panel/screens/sidebar/sidebar_view_model.dart';

// void main() => runApp(const AdminPanel());

// class AdminPanel extends StatelessWidget {
//   const AdminPanel({super.key});

//   @override //flutter build windows
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // Provide the SidebarViewModel for the sidebar
//         ChangeNotifierProvider(create: (context) => SidebarViewModel()),
//         ChangeNotifierProvider(create: (context) => NomineeViewModel()),
//         ChangeNotifierProvider(create: (context) => RegUserViewModel()),
//         ChangeNotifierProvider(create: (context) => LoanProvider()),
//         ChangeNotifierProvider(create: (context) => AuthViewModel()),
//         ChangeNotifierProvider(
//             create: (context) => DepositViewModel()..fetchBalances()),
//       ],
//       child: MaterialApp(
//         title: "Admin Panel",
//         // home: DashboardView(),
//         home: LoginScreen(),
//       ),
//     );
//   }
// }

//UPdated

import 'package:admin_panel/configs/routes/routes.dart';
import 'package:admin_panel/configs/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// View Models (State Management)
import 'package:admin_panel/screens/sidebar/sidebar_view_model.dart';
import 'package:admin_panel/screens/dashboard/all_user/reg_user_view_mode.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_provider.dart';
import 'package:admin_panel/screens/dashboard/deposit/deposit_view_model.dart';
import 'package:admin_panel/screens/login/auth_view_model.dart';

void main() {
  runApp(const AdminPanel());
}

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Sidebar ViewModel: Manages sidebar state (e.g. selection, expansion)
        ChangeNotifierProvider(create: (_) => SidebarViewModel()),
        ChangeNotifierProvider(create: (_) => RegUserViewModel()),
        ChangeNotifierProvider(create: (_) => LoanProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(
          create: (_) => DepositViewModel()..fetchBalances(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',

        // This is the initial route indicating from where our app will start
        initialRoute: RoutesName.loginScreen,
        onGenerateRoute: Routes.generateRoute, // Route generator for navigation
      ),
    );
  }
}
