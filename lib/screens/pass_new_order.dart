import 'package:flutter/material.dart';

class PassNewOrderScreen extends StatefulWidget {
  const PassNewOrderScreen({super.key});

  @override
  _PassNewOrderScreenState createState() => _PassNewOrderScreenState();
}

class _PassNewOrderScreenState extends State<PassNewOrderScreen> {
  final List<Map<String, dynamic>> _menuItems = [
    {'name': 'Espresso', 'price': 2.99},
    {'name': 'Cappuccino', 'price': 3.49},
    {'name': 'Latte', 'price': 3.99},
    {'name': 'Mocha', 'price': 4.29},
  ];

  final Map<String, int> _selectedItems = {};

  void _submitOrder() {
    if (_selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item.')),
      );
      return;
    }

    // Process the order (e.g., save to database)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order successfully placed!')),
    );

    // Clear the selections
    setState(() {
      _selectedItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pass New Order'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Items to Order',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading:
                          const Icon(Icons.fastfood, color: Color(0xFFC52127)),
                      title: Text(item['name']),
                      subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                if (_selectedItems.containsKey(item['name']) &&
                                    _selectedItems[item['name']]! > 0) {
                                  _selectedItems[item['name']] =
                                      _selectedItems[item['name']]! - 1;
                                  if (_selectedItems[item['name']] == 0) {
                                    _selectedItems.remove(item['name']);
                                  }
                                }
                              });
                            },
                          ),
                          Text(
                            _selectedItems[item['name']]?.toString() ?? '0',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle,
                                color: Colors.green),
                            onPressed: () {
                              setState(() {
                                if (_selectedItems.containsKey(item['name'])) {
                                  _selectedItems[item['name']] =
                                      _selectedItems[item['name']]! + 1;
                                } else {
                                  _selectedItems[item['name']] = 1;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC52127),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  'Submit Order',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
