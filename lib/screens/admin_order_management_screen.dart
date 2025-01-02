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
  final List<Map<String, dynamic>> products;
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
      isConfirmed: true,
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
      isConfirmed: false,
    ),
  ];

  bool showConfirmed = false;

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
      _showSnackBar('Order for ${order.user} confirmed!');
    } else if (result == false) {
      setState(() {
        orders.remove(order);
      });
      _showSnackBar('Order for ${order.user} removed!');
    }
  }

  void _deleteOrder(Order order) {
    setState(() {
      orders.remove(order);
    });
    _showSnackBar('Order for ${order.user} deleted!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildFilterButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? const Color(0xFFC52127) : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
        title: const Text(
          'Order Management',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Filter Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterButton(
                  label: 'Pending Orders',
                  isSelected: !showConfirmed,
                  onPressed: () {
                    setState(() {
                      showConfirmed = false;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _buildFilterButton(
                  label: 'Confirmed Orders',
                  isSelected: showConfirmed,
                  onPressed: () {
                    setState(() {
                      showConfirmed = true;
                    });
                  },
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
                                'Amount: ${order.amount.toStringAsFixed(2)}DT | Date: ${order.orderDate.toLocal().toString().split(' ')[0]}',
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
