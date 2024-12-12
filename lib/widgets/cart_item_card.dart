import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFC52127),
          child: Text(
            item['quantity'].toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(item['name']),
        subtitle:
            Text('\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.red),
              onPressed: onRemove,
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.green),
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
