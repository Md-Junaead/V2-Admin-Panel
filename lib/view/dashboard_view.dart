// dashboard_view.dart (updated)
import 'package:admin_panel/screens/dashboard/active_user.dart';
import 'package:admin_panel/screens/dashboard/all_user.dart';
import 'package:admin_panel/screens/dashboard/bank_withdraw.dart';
import 'package:admin_panel/screens/dashboard/crypto_withdraw.dart';
import 'package:admin_panel/screens/dashboard/deposit.dart';
import 'package:admin_panel/screens/dashboard/emi.dart';
import 'package:admin_panel/screens/dashboard/inactive_user.dart';
import 'package:admin_panel/screens/dashboard/loan.dart';
import 'package:admin_panel/view/sidebar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/view_models/sidebar_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(flex: 2, child: SidebarView()),
          Expanded(
            flex: 8,
            child: Consumer<SidebarViewModel>(
              builder: (context, vm, _) {
                switch (vm.selectedMenu) {
                  case 'All User':
                    return const AllUser();
                  case 'Active User':
                    return const ActiveUser();
                  case 'Inactive User':
                    return const InactiveUser();
                  case 'Deposit':
                    return const Deposit();
                  case 'Bank Withdraw':
                    return const BankWithdraw();
                  case 'Crypto Withdraw':
                    return const CryptoWithdraw();
                  case 'Loan':
                    return const Loan();
                  case 'Emi':
                    return const Emi();
                  // Add other cases here
                  default:
                    return Center(
                      child: Text('Current View: ${vm.selectedMenu}',
                          style: const TextStyle(fontSize: 24)),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
