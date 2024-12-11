import 'package:flutter/material.dart';

class AdminOrderManagementScreen extends StatelessWidget {
  const AdminOrderManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the number of orders
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text('Order ${index + 1}'),
            subtitle: const Text('Details of the order'),
            trailing: ElevatedButton(
              onPressed: () {
                // Place order logic
              },
              child: const Text('Place Order'),
            ),
          );
        },
      ),
    );
  }
}
