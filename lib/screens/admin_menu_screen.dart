import 'package:flutter/material.dart';

class AdminMenuScreen extends StatelessWidget {
  const AdminMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        backgroundColor: const Color(0xFFC52127),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new menu item
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the number of menu items
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.local_cafe),
            title: Text('Menu Item ${index + 1}'),
            subtitle: const Text('Description of the menu item'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Edit menu item
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Delete menu item
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
