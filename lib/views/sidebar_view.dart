import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/sidebar_view_model.dart';

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopSection(),
          _buildMiddleSection(context),
          _buildBottomSection(context),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: const [
          Icon(Icons.dashboard, color: Colors.white),
          SizedBox(width: 10),
          Text("Dashboard",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildMiddleSection(BuildContext context) {
    return Expanded(
      child: Material(
        child: ListView(
          children: [
            _buildMenuItem(context, "User", Icons.person),
            _buildMenuItem(context, "Deposit", Icons.account_balance),
            _buildMenuItem(context, "Withdraw", Icons.money),
            _buildMenuItem(context, "Loan", Icons.attach_money),
            _buildMenuItem(context, "EMI", Icons.payment),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    var viewModel = Provider.of<SidebarViewModel>(context);
    bool isSelected = viewModel.selectedMenu == title;
    return Material(
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.black),
        title: Text(title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        tileColor: isSelected ? Colors.blue : Colors.transparent,
        onTap: () => viewModel.setSelectedMenu(title),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage("https://via.placeholder.com/50")),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Username", style: TextStyle(color: Colors.white)),
              Text("Designation", style: TextStyle(color: Colors.white54)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
