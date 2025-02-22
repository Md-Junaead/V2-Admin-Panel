// sidebar_view.dart (updated)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/view_models/sidebar_view_model.dart';

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      color: Colors.blueGrey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopSection(),
          _buildMiddleSection(context),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
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
        color: Colors.transparent,
        child: ListView(
          children: [
            _buildExpandableMenuItem(context, "User", Icons.person_outline,
                ["All User", "Reg User", "Inactive User"]),
            _buildMenuItem(context, "Deposit", Icons.account_balance_wallet),
            _buildExpandableMenuItem(
                context, "Withdraw", Icons.payment, ["Bank", "Crypto"]),
            _buildMenuItem(context, "Loan", Icons.credit_card),
            _buildMenuItem(context, "EMI", Icons.money_off),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableMenuItem(BuildContext context, String title,
      IconData icon, List<String> subItems) {
    final vm = context.watch<SidebarViewModel>();
    final isExpanded = vm.expandedMenu == title;

    return Column(
      children: [
        _buildListTile(
          context: context,
          title: title,
          icon: icon,
          isExpanded: isExpanded,
          onTap: () => vm.toggleMenu(title),
        ),
        if (isExpanded)
          ...subItems.map((sub) => _buildSubItem(context, sub, title)),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    final vm = context.watch<SidebarViewModel>();
    return _buildListTile(
      context: context,
      title: title,
      icon: icon,
      isExpanded: false,
      onTap: () => vm.setSelectedMenu(title),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    final vm = context.watch<SidebarViewModel>();
    final isSelected = vm.selectedMenu == title;
    final isHovered = vm.hoveredMenu == title;

    return MouseRegion(
      onEnter: (_) => vm.setHoveredMenu(title),
      onExit: (_) => vm.setHoveredMenu(""),
      child: Container(
        color: _getBackgroundColor(isSelected, isHovered),
        child: ListTile(
          leading: Icon(icon, color: _getColor(isSelected, isHovered)),
          title: Text(title,
              style: TextStyle(
                color: _getColor(isSelected, isHovered),
              )),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildSubItem(BuildContext context, String title, String parent) {
    final vm = context.watch<SidebarViewModel>();
    final isSelected = vm.selectedMenu == title;
    final isHovered = vm.hoveredMenu == title;

    return MouseRegion(
      onEnter: (_) => vm.setHoveredMenu(title),
      onExit: (_) => vm.setHoveredMenu(""),
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Container(
          color: _getBackgroundColor(isSelected, isHovered),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(color: _getColor(isSelected, isHovered)),
            ),
            onTap: () {
              vm.setSelectedMenu(title);
              vm.setExpandedMenu(parent);
            },
          ),
        ),
      ),
    );
  }

  Color _getColor(bool isSelected, bool isHovered) {
    if (isSelected) return Colors.white;
    if (isHovered) return Colors.white70;
    return Colors.white54;
  }

  Color? _getBackgroundColor(bool isSelected, bool isHovered) {
    if (isSelected) return Colors.blue;
    if (isHovered) return Colors.blue.withOpacity(0.1);
    return null;
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://via.placeholder.com/50"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Admin User", style: TextStyle(color: Colors.white)),
                Text("Administrator", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
