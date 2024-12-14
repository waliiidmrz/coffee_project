import 'package:coffee_project/models/menu.dart';
import 'package:coffee_project/screens/StatisticsMenuScreen.dart';
import 'package:coffee_project/widgets/MenuCard.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
    ),
    Menu(
      id: 2,
      name: 'Cappuccino',
      price: 3.49,
      points: 15,
      createdAt: DateTime.now(),
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
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final pointsController = TextEditingController();
    String? image;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Menu Item'),
          content: SingleChildScrollView(
            child: Column(
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
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        image = pickedFile.path;
                      });
                    }
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

  void _editMenuItem(Menu menu) {
    final nameController = TextEditingController(text: menu.name);
    final priceController = TextEditingController(text: menu.price.toString());
    final pointsController =
        TextEditingController(text: menu.points.toString());
    String? image = menu.image;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Menu Item'),
          content: SingleChildScrollView(
            child: Column(
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
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        image = pickedFile.path;
                      });
                    }
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
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  menu.name = nameController.text;
                  menu.price =
                      double.tryParse(priceController.text) ?? menu.price;
                  menu.points =
                      int.tryParse(pointsController.text) ?? menu.points;
                  menu.image = image;
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

  void _deleteMenuItem(Menu menu) {
    setState(() {
      menuItems.remove(menu);
    });
  }

  void _navigateToStatistics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatisticsMenuScreen(
          totalItems: menuItems.length,
          totalPoints: menuItems.fold(0, (sum, item) => sum + item.points),
          totalRevenue: menuItems.fold(0, (sum, item) => sum + item.price),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return MenuCard(
            name: item.name,
            price: item.price,
            points: item.points,
            image: item.image,
            onEdit: () => _editMenuItem(item),
            onDelete: () => _deleteMenuItem(item),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: FloatingActionButton(
              heroTag: 'statistics',
              onPressed: _navigateToStatistics,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.bar_chart),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: FloatingActionButton(
              heroTag: 'add_menu',
              onPressed: _addMenuItem,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
