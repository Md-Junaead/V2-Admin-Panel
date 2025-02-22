import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/screens/deposit/deposit_view_model.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the screen width to adjust layout for responsiveness
          bool isWideScreen =
              constraints.maxWidth > 800; // Adjust this threshold as needed

          return Row(
            children: [
              Expanded(
                flex: isWideScreen
                    ? 8
                    : 12, // Adjust the flex depending on screen size
                child: Consumer<DepositViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Balance')),
                          DataColumn(label: Text('Deposit')),
                          DataColumn(label: Text('Packages')),
                          DataColumn(label: Text('Profit')),
                          DataColumn(label: Text('Referral')),
                          DataColumn(label: Text('Withdraw')),
                        ],
                        rows: viewModel.balances.map((balance) {
                          return DataRow(
                            cells: [
                              DataCell(Text(balance.id.toString())),
                              DataCell(Text(balance.user.name)),
                              DataCell(Text(balance.addBalance.toString())),
                              DataCell(Text(balance.depositB.toString())),
                              DataCell(Text(balance.packages)),
                              DataCell(Text(balance.profitB.toString())),
                              DataCell(Text(balance.referralB.toString())),
                              DataCell(Text(balance.withdrawB.toString())),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ), // Main content area
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<DepositViewModel>().fetchBalances(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
