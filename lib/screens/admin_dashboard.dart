import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontFamily: 'GianottenLTW04-Regular',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Welcome, Admin!',
              style: TextStyle(
                fontFamily: 'Arial_Regular',
                fontSize: 20,
                color: Color(0xFF0E3C3D),
              ),
            ),
            SizedBox(height: 20),
            Text('Manage products, users, and more.'),
          ],
        ),
      ),
    );
  }
}
