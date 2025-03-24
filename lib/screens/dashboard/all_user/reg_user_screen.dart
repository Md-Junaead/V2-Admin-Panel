import 'package:admin_panel/screens/dashboard/all_user/reg_user_view_mode.dart';
import 'package:admin_panel/screens/dashboard/user_details/user_details_screen.dart';
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
      // Fetch users when the screen is loaded
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
                      // Header Section: Title, Search Bar, Sort Dropdown
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Screen Title
                          const Text(
                            'All Users',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          // Search Bar
                          _buildSearchBar(userViewModel),
                          // Sort Dropdown
                          _buildSortDropdown(),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Data Table
                      _buildDataTable(context, constraints, userViewModel),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh user list
          Provider.of<RegUserViewModel>(context, listen: false).fetchUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  // Search bar widget
  Widget _buildSearchBar(RegUserViewModel userViewModel) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: '🔍 Search by ID, Name, Email, Phone',
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
        onChanged: (query) {
          userViewModel.searchUsers(query);
        },
      ),
    );
  }

  // Sort dropdown widget
  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButton<String>(
        value: _selectedSortOption,
        underline: const SizedBox(), // Remove default underline
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
          Provider.of<RegUserViewModel>(context, listen: false)
              .sortUsers(value!);
        },
      ),
    );
  }

  // Data Table widget
  Widget _buildDataTable(BuildContext context, BoxConstraints constraints,
      RegUserViewModel userViewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: constraints.maxWidth,
        ),
        child: DataTable(
          border: TableBorder.all(color: Colors.black12),
          headingRowHeight: 50,
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return TColors.buttonPrimary; // Table header color
            },
          ),
          columns: const [
            DataColumn(label: Text('User ID', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Name', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Email', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Phone No', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Address', style: _tableHeaderTextStyle)),
            DataColumn(label: Text('Country', style: _tableHeaderTextStyle)),
          ],
          rows: userViewModel.filteredUsers.map((user) {
            return DataRow(
              cells: [
                DataCell(
                  GestureDetector(
                    onTap: () {
                      // Navigate to the user details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailScreen(
                            userid: user.userid,
                            name: user.name,
                            email: user.email,
                            phoneNo: user.phoneNo ??
                                'N/A', // Use 'N/A' if phoneNo is null
                            address: user.address ??
                                'N/A', // Use 'N/A' if address is null
                            country: user.country,
                          ),
                        ),
                      );
                    },
                    child: Text(user.userid),
                  ),
                ),
                DataCell(Text(user.name)),
                DataCell(Text(user.email)),
                DataCell(Text(user.phoneNo ?? 'N/A')),
                DataCell(Text(user.address ?? 'N/A')),
                DataCell(Text(user.country)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // Table header text style
  static const TextStyle _tableHeaderTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 16,
  );
}
