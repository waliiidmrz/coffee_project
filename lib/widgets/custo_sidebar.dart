import 'package:BISOU/screens/ProfileAdmin.dart';
import 'package:BISOU/screens/Setting.dart';
import 'package:BISOU/screens/admin_user_list_screen.dart';
import 'package:BISOU/screens/profile_screen%20copy.dart';
import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200, // Adjust this height as needed
            child: DrawerHeader(
              child: Image.asset(
                'assets/images/bisou_logo.png',
                height: 200,
                width: 200,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileAdminScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Navigate to privacy policy screen
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Give Feedback'),
            onTap: () {
              // Navigate to feedback screen
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // Navigate to help & support screen
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
