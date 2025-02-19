import 'package:admin_panel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/sidebar_view_model.dart';

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      color: TColors.buttonPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopSection(), // Top section containing Dashboard title
          _buildMiddleSection(context), // Middle section containing menu items
          _buildBottomSection(context), // Bottom section with user profile
        ],
      ),
    );
  }

  /// Builds the top section of the sidebar
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

  /// Builds the middle section containing menu items and submenus
  Widget _buildMiddleSection(BuildContext context) {
    return Expanded(
      child: Material(
        child: ListView(
          children: [
            _buildExpandableMenuItem(context, "User", Icons.person,
                ["All User", "Active User", "Inactive User"]),
            _buildMenuItem(context, "Deposit", Icons.account_balance),
            _buildExpandableMenuItem(
                context, "Withdraw", Icons.money, ["Bank", "Crypto"]),
            _buildMenuItem(context, "Loan", Icons.attach_money),
            _buildMenuItem(context, "EMI", Icons.payment),
          ],
        ),
      ),
    );
  }

  /// Builds a collapsible menu item with submenus
  Widget _buildExpandableMenuItem(BuildContext context, String title,
      IconData icon, List<String> subItems) {
    var viewModel = Provider.of<SidebarViewModel>(context);
    bool isExpanded = viewModel.selectedMenu == title;

    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: isExpanded ? Colors.white : Colors.black),
          title: Text(title,
              style:
                  TextStyle(color: isExpanded ? Colors.white : Colors.black)),
          tileColor: isExpanded ? Colors.blue : Colors.transparent,
          onTap: () => viewModel.toggleMenu(title),
        ),
        if (isExpanded)
          Column(
            children: subItems
                .map((subItem) => _buildSubMenuItem(context, subItem))
                .toList(),
          ),
      ],
    );
  }

  /// Builds a standard menu item without submenus
  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    var viewModel = Provider.of<SidebarViewModel>(context);
    bool isSelected = viewModel.selectedMenu == title;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.white : Colors.black),
      title: Text(title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      tileColor: isSelected ? Colors.blue : Colors.transparent,
      onTap: () => viewModel.setSelectedMenu(title),
    );
  }

  /// Builds submenu items
  Widget _buildSubMenuItem(BuildContext context, String title) {
    var viewModel = Provider.of<SidebarViewModel>(context);
    bool isSelected = viewModel.selectedMenu == title;
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: ListTile(
        title: Text(title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        tileColor: isSelected ? Colors.blue : Colors.transparent,
        onTap: () => viewModel.setSelectedMenu(title),
      ),
    );
  }

  /// Builds the bottom section with user profile and dropdown
  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
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
