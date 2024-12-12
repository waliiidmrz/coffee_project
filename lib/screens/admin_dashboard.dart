import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<Map<String, dynamic>> currentOrder = [];
  double totalAmount = 0.0;

  void _addToOrder(Map<String, dynamic> item) {
    setState(() {
      currentOrder.add(item);
      totalAmount += item['price'];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} added to the order')),
    );
  }

  void _passOrder() {
    // Logic for passing the order
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order passed successfully!')),
    );
    setState(() {
      currentOrder.clear();
      totalAmount = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFC52127),
      ),
<<<<<<< HEAD
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
=======
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
>>>>>>> c0b447fb63056d5238b522070753ea3ad75bfae0
              'Welcome, Admin!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0E3C3D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Manage products, users, and orders below.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildDashboardCard(
                    context,
                    icon: Icons.shopping_cart,
                    title: 'Add Items to Order',
                    subtitle: 'Add items to the current order.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddOrderScreen(
                            addToOrderCallback: _addToOrder,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.list,
                    title: 'View Current Order',
                    subtitle: 'See items in the current order.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewOrderScreen(
                            currentOrder: currentOrder,
                            totalAmount: totalAmount,
                            passOrderCallback: _passOrder,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFC52127), size: 40),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward, color: Color(0xFFC52127)),
        onTap: onTap,
      ),
    );
  }
}

class AddOrderScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) addToOrderCallback;

  AddOrderScreen({super.key, required this.addToOrderCallback});

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Espresso', 'price': 2.99},
    {'name': 'Cappuccino', 'price': 3.49},
    {'name': 'Latte', 'price': 4.99},
    {'name': 'Mocha', 'price': 5.29},
    {'name': 'Macchiato', 'price': 4.79},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items to Order'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(item['name']),
              subtitle: Text('Price: \$${item['price'].toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                onPressed: () {
                  addToOrderCallback(item);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC52127),
                ),
                child: const Text('Add to Order'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ViewOrderScreen extends StatelessWidget {
  final List<Map<String, dynamic>> currentOrder;
  final double totalAmount;
  final VoidCallback passOrderCallback;

  const ViewOrderScreen({
    super.key,
    required this.currentOrder,
    required this.totalAmount,
    required this.passOrderCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Order'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: currentOrder.length,
                itemBuilder: (context, index) {
                  final item = currentOrder[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle:
                          Text('Price: \$${item['price'].toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: passOrderCallback,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC52127),
              ),
              child: const Text('Pass Order'),
            ),
          ],
        ),
      ),
    );
  }
}
