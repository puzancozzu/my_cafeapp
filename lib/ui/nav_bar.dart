import 'package:cafe_app/ui/pendingorder_page_ui.dart';
import 'package:cafe_app/ui/sales_order_page_ui.dart';
import 'package:flutter/material.dart';

import 'decide_later_page.dart';
import 'homepage_ui.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

// class _NavBarState extends State<NavBar> {
//   int _currentIndex = 0;
//
//
//   final List<Widget> _pages = [
//     HomepageUi(),
//     SalesOrderPageUi(),
//     PendingorderPageUi(),
//     DecideLaterPage(),
//   ];
//
//   void _onFabPressed() {
//     switch (_currentIndex) {
//       case 0:
//         print("FAB on Home Page");
//         break;
//       case 1:
//         print("FAB on Order Page");
//         break;
//       case 2:
//         print("FAB on Pending Page");
//         break;
//       case 3:
//         print("FAB on More Page");
//         break;
//     }
//   }
//
//   void _onTabSelected(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//
//       floatingActionButton: Container(
//         height: 72,
//         width: 72,
//         margin: const EdgeInsets.only(top: 8),
//         child: FloatingActionButton(
//           onPressed: _onFabPressed,
//           backgroundColor: Color(0xffA96844),
//           shape: const CircleBorder(),
//           elevation: 0,
//           child: const Icon(Icons.add, size: 30),
//         ),
//       ),
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         color: Color(0xffA96844),
//         elevation: 0,
//         child: SizedBox(
//           height: 64,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildNavItem(Icons.home, "Home", 0),
//                 _buildNavItem(Icons.list_alt, "Order", 1),
//                 const SizedBox(width: 38), // space for FAB
//                 _buildNavItem(Icons.pending_actions, "Pending", 2),
//                 _buildNavItem(Icons.more_horiz, "More", 3),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildNavItem(IconData icon, String label, int index) {
//     final isSelected = _currentIndex == index;
//     return GestureDetector(
//       onTap: () => _onTabSelected(index),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               size: 30,
//               color: isSelected ? Colors.brown : Colors.grey,
//             ),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? Colors.brown : Colors.grey,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    HomepageUi(),
    SalesOrderPageUi(),
    PendingorderPageUi(),
    DecideLaterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.blueGrey),
      //         child: Text(
      //           'Navigation Menu',
      //           style: TextStyle(color: Colors.white, fontSize: 20),
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text('Home'),
      //         onTap: () {
      //           setState(() {
      //             _currentIndex = 0;
      //           });
      //           Navigator.pop(context); // Close the drawer
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.currency_exchange),
      //         title: const Text('Orders'),
      //         onTap: () {
      //           setState(() {
      //             _currentIndex = 1;
      //           });
      //           Navigator.pop(context); // Close the drawer
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.pending_actions),
      //         title: const Text('Pending Order'),
      //         onTap: () {
      //           setState(() {
      //             _currentIndex = 2;
      //           });
      //           Navigator.pop(context); // Close the drawer
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Profile'),
      //         onTap: () {
      //           setState(() {
      //             _currentIndex = 3;
      //           });
      //           Navigator.pop(context); // Close the drawer
      //         },
      //       ),
      //
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.pending_actions), label: 'Pending Orders',),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
