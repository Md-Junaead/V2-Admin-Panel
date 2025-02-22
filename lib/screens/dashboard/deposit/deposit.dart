import 'package:admin_panel/screens/dashboard/deposit/deposit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Deposit extends StatelessWidget {
  const Deposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              children: [
                AppBar(title: const Text("Balance List")),
                Expanded(
                  child: Consumer<BalanceViewModel>(
                    builder: (context, balanceViewModel, child) {
                      if (balanceViewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (balanceViewModel.errorMessage.isNotEmpty) {
                        return Center(
                            child: Text(balanceViewModel.errorMessage));
                      } else if (balanceViewModel.balances.isEmpty) {
                        return const Center(child: Text("No data available"));
                      }

                      return ListView.builder(
                        itemCount: balanceViewModel.balances.length,
                        itemBuilder: (context, index) {
                          final balance = balanceViewModel.balances[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(balance.userRegistration.name),
                              subtitle:
                                  Text("Balance: \$${balance.addBalance}"),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Deposit: \$${balance.dipositB}"),
                                  Text("Profit: \$${balance.profitB}"),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<BalanceViewModel>(context, listen: false).loadBalances();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
