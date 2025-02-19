// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MenuProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: AdminPanel(),
//       ),
//     );
//   }
// }

// class AdminPanel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(flex: 2, child: SidebarMenu()), // 20% Sidebar
//           Expanded(
//             flex: 8,
//             child: Consumer<MenuProvider>(
//               builder: (context, provider, child) {
//                 return provider.selectedScreen;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SidebarMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<MenuProvider>(context);
//     return Container(
//       color: Colors.grey[200],
//       child: Column(
//         children: [
//           // Top Section
//           MenuItem(icon: Icons.dashboard, title: "Dashboard", index: 0),
//           Divider(),
//           // Middle Section
//           SubMenuItem(
//               title: "User",
//               subItems: ["All User", "Active User", "Inactive User"]),
//           MenuItem(icon: Icons.account_balance, title: "Deposit", index: 4),
//           SubMenuItem(
//               title: "Withdraw",
//               subItems: ["Bank Withdraw", "Crypto Withdraw"]),
//           MenuItem(icon: Icons.money, title: "Loan", index: 7),
//           MenuItem(icon: Icons.payments, title: "EMI", index: 8),
//           Spacer(),
//           // Bottom Section
//           AdminSection(),
//         ],
//       ),
//     );
//   }
// }

// class MenuItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final int index;
//   MenuItem({required this.icon, required this.title, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<MenuProvider>(context);
//     bool isSelected = provider.selectedIndex == index;
//     return InkWell(
//       onTap: () => provider.selectMenu(index),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         color: isSelected ? Colors.blue : Colors.transparent,
//         child: Row(
//           children: [
//             Icon(icon, color: isSelected ? Colors.white : Colors.black),
//             SizedBox(width: 10),
//             Text(
//               title,
//               style: TextStyle(color: isSelected ? Colors.white : Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SubMenuItem extends StatefulWidget {
//   final String title;
//   final List<String> subItems;
//   SubMenuItem({required this.title, required this.subItems});

//   @override
//   _SubMenuItemState createState() => _SubMenuItemState();
// }

// class _SubMenuItemState extends State<SubMenuItem> {
//   bool isExpanded = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           title: Text(widget.title),
//           trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
//           onTap: () {
//             setState(() {
//               isExpanded = !isExpanded;
//             });
//           },
//         ),
//         if (isExpanded)
//           Column(
//             children: widget.subItems
//                 .map((subItem) => Padding(
//                       padding: EdgeInsets.only(left: 30),
//                       child: MenuItem(
//                           icon: Icons.circle,
//                           title: subItem,
//                           index: widget.subItems.indexOf(subItem) + 1),
//                     ))
//                 .toList(),
//           ),
//       ],
//     );
//   }
// }

// class AdminSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(radius: 30, backgroundColor: Colors.blue),
//         SizedBox(height: 10),
//         Text("Admin Name"),
//         Text("Admin Designation", style: TextStyle(fontSize: 12)),
//         SizedBox(height: 10),
//         IconButton(icon: Icon(Icons.logout), onPressed: () {}),
//       ],
//     );
//   }
// }

// class MenuProvider extends ChangeNotifier {
//   int selectedIndex = 0;
//   Widget selectedScreen = DashboardScreen();

//   void selectMenu(int index) {
//     selectedIndex = index;
//     switch (index) {
//       case 0:
//         selectedScreen = DashboardScreen();
//         break;
//       case 1:
//         selectedScreen = AllUserScreen();
//         break;
//       case 4:
//         selectedScreen = DepositScreen();
//         break;
//       case 7:
//         selectedScreen = LoanScreen();
//         break;
//       case 8:
//         selectedScreen = EmiScreen();
//         break;
//       default:
//         selectedScreen = Placeholder();
//     }
//     notifyListeners();
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("Dashboard"));
//   }
// }

// class AllUserScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("All Users"));
//   }
// }

// class DepositScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("Deposit"));
//   }
// }

// class LoanScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("Loan"));
//   }
// }

// class EmiScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("EMI"));
//   }
// }

// // // Builds the bottom section with user profile
// //   Widget _buildBottomSection() {
// //     return Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: Row(
// //         children: [
// //           const CircleAvatar(
// //             backgroundImage: NetworkImage("https://via.placeholder.com/50"),
// //           ),
// //           const SizedBox(width: 10),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: const [
// //                 Text(
// //                   "Username",
// //                   style: TextStyle(color: Colors.white),
// //                 ),
// //                 Text(
// //                   "Designation",
// //                   style: TextStyle(color: Colors.white54),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
// //             onPressed: () {
// //               // Handle user profile dropdown actions here
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
