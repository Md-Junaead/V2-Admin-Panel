import 'package:admin_panel/configs/utils/constants/colors.dart';
import 'package:admin_panel/screens/sidebar/sidebar_view.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/screens/dashboard/loan/loan_model.dart'; // Import the LoanModel

class LoanUserDetailScreen extends StatelessWidget {
  final LoanModel loan;

  const LoanUserDetailScreen({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // Updated line: Add Row layout to include sidebar and content
        children: [
          const Expanded(
            flex: 2,
            child:
                SidebarView(), // Updated line: Include SidebarView on the left side
          ),
          Expanded(
            flex: 8,
            child: Scaffold(
              // Updated line: Wrap content in an inner Scaffold for modern app bar
              appBar: AppBar(
                title: const Text(
                  'Loan Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        TColors.buttonPrimary, // Use a custom primary color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                ),
                backgroundColor:
                    TColors.buttonPrimary, // Custom color for AppBar
                elevation: 4,
              ),
              body: Container(
                color: Colors
                    .grey[100], // Updated background color for modern look
                child: Padding(
                  padding: const EdgeInsets.all(
                      24.0), // Increased padding for modern spacing
                  child: SingleChildScrollView(
                    child: Card(
                      // Added Card for elevated modern design
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            20.0), // Added internal padding for card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                                'User ID', loan.userRegistration.userid),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Name', loan.userRegistration.name),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow(
                                'Email', loan.userRegistration.email),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Eligible Balance',
                                '\$${loan.eligeblebalancey.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Loan Amount',
                                '\$${loan.loanamuont.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Weekly Pay',
                                '\$${loan.weeklypay.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Total Pay',
                                '\$${loan.totalpay.toStringAsFixed(2)}'),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Tenure', loan.tenure.toString()),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Status', loan.status),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            _buildDetailRow('Request Date',
                                loan.requestdate.toIso8601String()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated line: Added helper method for consistent detail row styling with text wrapping
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Flexible(
            child: Text(
              value,
              softWrap: true,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
