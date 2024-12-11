import 'package:flutter/material.dart';

class AdminUserListScreen extends StatelessWidget {
  const AdminUserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the number of users
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text('User ${index + 1}'),
            subtitle: const Text('Details about the user'),
            trailing: IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                // Navigate to user details screen
              },
            ),
          );
        },
      ),
    );
  }
}
