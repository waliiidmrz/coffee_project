import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'id': 1,
      'product': 'Cappuccino',
      'price': 4.53,
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Delivered',
    },
    {
      'id': 2,
      'product': 'Latte',
      'price': 3.99,
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Preparing',
    },
    {
      'id': 3,
      'product': 'Espresso',
      'price': 2.99,
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Pending',
    },
  ];

  void editOrder(BuildContext context, int orderId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing order $orderId')),
    );
  }

  void deleteOrder(BuildContext context, int orderId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted order $orderId')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      order['imageUrl'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['product'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$${order['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Status: ${order['status']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    editOrder(context, order['id']),
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(color: Color(0xFFC52127)),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    deleteOrder(context, order['id']),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
