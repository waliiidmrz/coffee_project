import 'package:BISOU/screens/gift_card_screen.dart';
import 'package:BISOU/screens/order_screen.dart';
import 'package:BISOU/screens/profile_screen.dart';
import 'package:BISOU/widgets/custo_sidebar.dart';
import 'package:BISOU/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      OrderScreen(),
      GiftCardScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Home",
        activeColorPrimary: const Color(0xFFC52127), // Your red palette
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.shopping_cart),
        title: "Orders",
        activeColorPrimary: const Color(0xFFC52127),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.gift),
        title: "Gift Card",
        activeColorPrimary: const Color(0xFFC52127),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Profile",
        activeColorPrimary: const Color(0xFFC52127),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Bisou'),
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
