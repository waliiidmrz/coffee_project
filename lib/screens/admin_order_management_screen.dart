import 'package:flutter/material.dart';

class Order {
  final String localization;
  final int latitude;
  final int longitude;
  final double amount;
  final DateTime orderDate;
  final String user;
  final String menu;

  Order({
    required this.localization,
    required this.latitude,
    required this.longitude,
    required this.amount,
    required this.orderDate,
    required this.user,
    required this.menu,
  });
}

class AdminOrderManagementScreen extends StatefulWidget {
  const AdminOrderManagementScreen({Key? key}) : super(key: key);

  @override
  _AdminOrderManagementScreenState createState() =>
      _AdminOrderManagementScreenState();
}

class _AdminOrderManagementScreenState
    extends State<AdminOrderManagementScreen> {
  final List<Order> orders = [
    Order(
      localization: 'Downtown Cafe',
      latitude: 12345,
      longitude: 54321,
      amount: 29.99,
      orderDate: DateTime.now(),
      user: 'John Doe',
      menu: 'Cappuccino',
    ),
    Order(
      localization: 'Uptown Bistro',
      latitude: 67890,
      longitude: 98765,
      amount: 15.49,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
      user: 'Jane Smith',
      menu: 'Espresso',
    ),
  ];

  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Order Details for ${order.user}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Localization: ${order.localization}'),
              Text('Latitude: ${order.latitude}'),
              Text('Longitude: ${order.longitude}'),
              Text('Amount: \$${order.amount.toStringAsFixed(2)}'),
              Text(
                  'Order Date: ${order.orderDate.toLocal().toString().split(' ')[0]}'),
              Text('Menu Item: ${order.menu}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading:
                  const Icon(Icons.shopping_cart, color: Color(0xFFC52127)),
              title: Text(
                'Order for ${order.user}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Amount: \$${order.amount.toStringAsFixed(2)} | Date: ${order.orderDate.toLocal().toString().split(' ')[0]}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.info, color: Colors.blue),
                    onPressed: () => _showOrderDetails(order),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC52127),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Order for ${order.user} placed successfully!')),
                      );
                    },
                    child: const Text('Place Order'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
