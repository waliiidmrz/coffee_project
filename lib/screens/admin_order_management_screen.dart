import 'package:flutter/material.dart';
import 'Confirm_Order_admin.dart';

class Order {
  final String localization;
  final int latitude;
  final int longitude;
  final double amount;
  final DateTime orderDate;
  final String user;
  final String menu;
  final List<Map<String, dynamic>> products; // Products list
  bool isConfirmed;

  Order({
    required this.localization,
    required this.latitude,
    required this.longitude,
    required this.amount,
    required this.orderDate,
    required this.user,
    required this.menu,
    required this.products,
    this.isConfirmed = false,
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
      products: [
        {'name': 'Cappuccino', 'quantity': 1, 'price': 4.99},
        {'name': 'Latte', 'quantity': 2, 'price': 3.49},
      ],
      isConfirmed: true, // Confirmed order
    ),
    Order(
      localization: 'Uptown Bistro',
      latitude: 67890,
      longitude: 98765,
      amount: 15.49,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
      user: 'Jane Smith',
      menu: 'Espresso',
      products: [
        {'name': 'Espresso', 'quantity': 1, 'price': 2.99},
        {'name': 'Americano', 'quantity': 2, 'price': 3.25},
      ],
      isConfirmed: false, // Pending order
    ),
    Order(
      localization: 'City Center Diner',
      latitude: 34567,
      longitude: 76543,
      amount: 42.99,
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
      user: 'Alice Brown',
      menu: 'Mocha',
      products: [
        {'name': 'Mocha', 'quantity': 2, 'price': 5.99},
      ],
      isConfirmed: false, // Pending order
    ),
  ];

  bool showConfirmed = false; // Filter state

  void _navigateToOrderConfirmation(Order order) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(order: order),
      ),
    );

    if (result == true) {
      setState(() {
        order.isConfirmed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order for ${order.user} confirmed!'),
        ),
      );
    } else if (result == false) {
      setState(() {
        orders.remove(order);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order for ${order.user} removed!'),
        ),
      );
    }
  }

  void _deleteOrder(Order order) {
    setState(() {
      orders.remove(order);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order for ${order.user} deleted!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = orders
        .where(
            (order) => showConfirmed ? order.isConfirmed : !order.isConfirmed)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showConfirmed = false; // Show pending orders
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !showConfirmed
                        ? const Color.fromARGB(255, 60, 128, 224)
                        : const Color.fromARGB(255, 202, 201, 201),
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Pending Orders'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showConfirmed = true; // Show confirmed orders
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showConfirmed
                        ? const Color.fromARGB(255, 60, 128, 224)
                        : const Color.fromARGB(255, 202, 201, 201),
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Confirmed Orders'),
                ),
              ],
            ),
          ),
          // Order List
          Expanded(
            child: filteredOrders.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.shopping_cart,
                            color: Color(0xFFC52127),
                          ),
                          title: Text(
                            'Order for ${order.user}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Amount: \$${order.amount.toStringAsFixed(2)} | Date: ${order.orderDate.toLocal().toString().split(' ')[0]}',
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Status: ${order.isConfirmed ? 'Confirmed' : 'Pending'}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: order.isConfirmed
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC52127),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () =>
                                    _navigateToOrderConfirmation(order),
                                child: const Text('See Order'),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteOrder(order),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No ${showConfirmed ? 'confirmed' : 'pending'} orders found!',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
