import 'package:admin_panel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deposit_view_model.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    String selectedSortOption = 'New';

    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for contrast
      body: Consumer<DepositViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          // Table Header: Title, Search Bar, Sort Dropdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Screen Title
                              const Text(
                                'Deposit Details',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Search Bar
                              Container(
                                width: 320,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: searchController,
                                  decoration: const InputDecoration(
                                    hintText: '🔍 Search by ID or Name',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (query) {
                                    viewModel.searchBalances(query);
                                  },
                                ),
                              ),
                              // Sort Dropdown
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedSortOption,
                                  underline: SizedBox(), // Remove default line
                                  items: ['New', 'Old', 'Name', 'Country']
                                      .map((option) => DropdownMenuItem(
                                            value: option,
                                            child: Text(option),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    selectedSortOption = value!;
                                    viewModel.sortBalances(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Data Table with Fixed Header
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth,
                              ),
                              child: SingleChildScrollView(
                                child: DataTable(
                                  columnSpacing: 10,
                                  border:
                                      TableBorder.all(color: Colors.black12),
                                  headingRowHeight: 50,
                                  headingRowColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return TColors
                                          .buttonPrimary; // Table header color
                                    },
                                  ),
                                  columns: const [
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'ID',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'UserID',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Name',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Country',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Add Balance',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Deposit B',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Package',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Profit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Withdraw B',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    )),
                                  ],
                                  // Inside your DepositScreen widget (UI)
                                  rows: viewModel.balances.map((balance) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(balance.id.toString())),
                                        DataCell(Text(balance.userId)),
                                        DataCell(Text(balance.name)),
                                        DataCell(Text(balance.country)),
                                        DataCell(Text(
                                            balance.addBalance.toString())),
                                        DataCell(
                                            Text(balance.depositB.toString())),
                                        DataCell(Text(balance.packages)),
                                        DataCell(
                                            Text(balance.profitB.toString())),
                                        DataCell(
                                            Text(balance.withdrawB.toString())),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger the fetch balances action when the button is pressed
          context.read<DepositViewModel>().fetchBalances();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
