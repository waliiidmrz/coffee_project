import 'package:flutter/material.dart';
import 'dart:io';

class MenuCard extends StatelessWidget {
  final String name;
  final double price;
  final int points;
  final String? image;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MenuCard({
    Key? key,
    required this.name,
    required this.price,
    required this.points,
    this.image,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: image != null
            ? Image.file(
                File(image!),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.local_cafe, color: Color(0xFFC52127)),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Price: \$${price.toStringAsFixed(2)} | Points: $points',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
