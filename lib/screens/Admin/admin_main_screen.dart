import 'package:BISOU/widgets/custo_sidebar.dart';
import 'package:BISOU/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// Import screens for the admin navigation bar
import 'admin_dashboard_screen.dart';
import 'admin_user_list_screen.dart';
import 'admin_menu_screen.dart';
import 'admin_order_management_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const AdminDashboardScreen(), // Dashboard
      AdminUserListScreen(), // User List
      const AdminMenuScreen(), // Menu Management
      const AdminOrderManagementScreen(), // Order Management
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Dashboard",
        activeColorPrimary: const Color(0xFFC52127), // Your red palette
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_2),
        title: "Users",
        activeColorPrimary: const Color(0xFFC52127),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.doc),
        title: "Menu",
        activeColorPrimary: const Color(0xFFC52127),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: "Orders",
        activeColorPrimary: const Color(0xFFC52127),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Bisou'),
      endDrawer: const CustomSidebar(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        navBarHeight: kBottomNavigationBarHeight,
        decoration: const NavBarDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        navBarStyle: NavBarStyle.style1, // Customize the nav bar style here
      ),
    );
  }
}
