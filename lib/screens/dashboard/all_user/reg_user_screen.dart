import 'package:admin_panel/screens/dashboard/all_user/reg_user_view_mode.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegUserScreen extends StatefulWidget {
  const RegUserScreen({super.key});

  @override
  State<RegUserScreen> createState() => _RegUserScreenState();
}

class _RegUserScreenState extends State<RegUserScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSortOption = 'New';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<RegUserViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for contrast
      body: userViewModel.isLoading
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
                            'Registered Users',
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
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: '🔍 Search by ID, Name, Email, Phone',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                border: InputBorder.none,
                              ),
                              onChanged: (query) {
                                userViewModel.searchUsers(query);
                              },
                            ),
                          ),
                          // Sort Dropdown
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedSortOption,
                              underline: SizedBox(), // Remove default line
                              items: ['New', 'Old', 'Name', 'Email', 'Country']
                                  .map((option) => DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedSortOption = value!;
                                });
                                userViewModel.sortUsers(value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Data Table
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                          ),
                          child: DataTable(
                            border: TableBorder.all(color: Colors.black12),
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
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('User ID',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16)),
                              )),
                              DataColumn(
                                  label: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16)),
                              )),
                              DataColumn(
                                  label: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Email',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16)),
                              )),
                              DataColumn(
                                  label: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Phone No',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16)),
                              )),
                              DataColumn(
                                  label: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Address',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16)),
                              )),
                              DataColumn(
                                  label: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Country',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16)),
                              )),
                            ],
                            rows: userViewModel.filteredUsers.map((user) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(user.userId)),
                                  DataCell(Text(user.name)),
                                  DataCell(Text(user.email)),
                                  DataCell(Text(user.phoneNo)),
                                  DataCell(Text(user.address)),
                                  DataCell(Text(user.country)),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
