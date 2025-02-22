import 'package:admin_panel/screens/dashboard/activeuser/reg_user_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegUserScreen extends StatefulWidget {
  const RegUserScreen({super.key});

  @override
  State<RegUserScreen> createState() => _RegUserScreenState();
}

class _RegUserScreenState extends State<RegUserScreen> {
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
      appBar: AppBar(title: const Text('User List')),
      body: userViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints
                                .maxWidth, // Make table stretch full width
                          ),
                          child: DataTable(
                            border: TableBorder.all(color: Colors.black12),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'User ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Phone No',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Country',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            rows: userViewModel.users.map((user) {
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
    );
  }
}
