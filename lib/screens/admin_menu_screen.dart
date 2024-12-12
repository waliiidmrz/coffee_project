import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Menu {
  final int id;
  String name;
  double price;
  int points;
  final DateTime createdAt;
  final bool canDelete;
  final bool isDefault;
  String? image;

  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.points,
    required this.createdAt,
    this.canDelete = true,
    this.isDefault = false,
    this.image,
  });
}

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({Key? key}) : super(key: key);

  @override
  _AdminMenuScreenState createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  final ImagePicker _picker = ImagePicker();

  List<Menu> menuItems = [
    Menu(
      id: 1,
      name: 'Espresso',
      price: 2.99,
      points: 10,
      createdAt: DateTime.now(),
      image: null,
    ),
    Menu(
      id: 2,
      name: 'Cappuccino',
      price: 3.49,
      points: 15,
      createdAt: DateTime.now(),
      image: null,
    ),
  ];

  Future<void> _selectImage(Function(String) onImageSelected) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        onImageSelected(pickedFile.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting image: $e')),
      );
    }
  }

  void _addMenuItem() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final priceController = TextEditingController();
        final pointsController = TextEditingController();
        String? image;

        return AlertDialog(
          title: const Text('Add Menu Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: pointsController,
                decoration: const InputDecoration(labelText: 'Points'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  _selectImage((path) {
                    setState(() {
                      image = path;
                    });
                  });
                },
                child: const Text('Select Image'),
              ),
              if (image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    File(image!),
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  menuItems.add(
                    Menu(
                      id: menuItems.length + 1,
                      name: nameController.text,
                      price: double.tryParse(priceController.text) ?? 0.0,
                      points: int.tryParse(pointsController.text) ?? 0,
                      createdAt: DateTime.now(),
                      image: image,
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editMenuItem(Menu item) {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController(text: item.name);
        final priceController =
            TextEditingController(text: item.price.toString());
        final pointsController =
            TextEditingController(text: item.points.toString());
        String? image = item.image;

        return AlertDialog(
          title: const Text('Edit Menu Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: pointsController,
                decoration: const InputDecoration(labelText: 'Points'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  _selectImage((path) {
                    setState(() {
                      image = path;
                    });
                  });
                },
                child: const Text('Select Image'),
              ),
              if (image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    File(image!),
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  item.name = nameController.text;
                  item.price =
                      double.tryParse(priceController.text) ?? item.price;
                  item.points =
                      int.tryParse(pointsController.text) ?? item.points;
                  item.image = image;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteMenuItem(Menu item) {
    if (item.canDelete) {
      setState(() {
        menuItems.remove(item);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This item cannot be deleted.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        backgroundColor: const Color(0xFFC52127),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addMenuItem,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: item.image != null
                  ? Image.file(
                      File(item.image!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.local_cafe, color: Color(0xFFC52127)),
              title: Text(item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Price: \$${item.price.toStringAsFixed(2)} | Points: ${item.points}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editMenuItem(item),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteMenuItem(item),
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
