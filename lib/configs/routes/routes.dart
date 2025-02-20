import 'package:admin_panel/configs/routes/routes_name.dart';
import 'package:admin_panel/screens/dashboard/active_user.dart';
import 'package:admin_panel/screens/dashboard/allUser/all_user.dart';
import 'package:admin_panel/screens/dashboard/bank_withdraw.dart';
import 'package:admin_panel/screens/dashboard/crypto_withdraw.dart';
import 'package:admin_panel/screens/dashboard/deposit.dart';
import 'package:admin_panel/screens/dashboard/emi.dart';
import 'package:admin_panel/screens/dashboard/inactive_user.dart';
import 'package:admin_panel/screens/dashboard/loan.dart';
import 'package:admin_panel/view/dashboard_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //VerticalMenu routes

      case RoutesName.dashBoard:
        return MaterialPageRoute(
            builder: (BuildContext context) => DashboardView());

      case RoutesName.allUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AllUser());

      case RoutesName.activeUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ActiveUser());

      case RoutesName.inactiveUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => const InactiveUser());

      case RoutesName.deposit:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Deposit());

      case RoutesName.bankWithdraw:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BankWithdraw());

      case RoutesName.cryptoWithdraw:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CryptoWithdraw());

      case RoutesName.loan:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Loan());

      case RoutesName.emiScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EmiScreen());

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
