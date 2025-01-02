import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/menu.dart';
import '../screens/StatisticsMenuScreen.dart';

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
      image: 'assets/images/latte.jpeg',
    ),
    Menu(
      id: 2,
      name: 'Cappuccino',
      price: 3.49,
      points: 15,
      createdAt: DateTime.now(),
      image: 'assets/images/macchiato.jpg',
    ),
  ];

  void _addOrEditMenuItem({Menu? menu}) {
    final nameController =
        TextEditingController(text: menu != null ? menu.name : '');
    final priceController =
        TextEditingController(text: menu != null ? menu.price.toString() : '');
    final pointsController =
        TextEditingController(text: menu != null ? menu.points.toString() : '');
    String? imagePath = menu?.image;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(menu != null ? 'Edit Menu Item' : 'Add Menu Item'),
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        imagePath = pickedFile.path;
                      });
                    }
                  },
                  child: const Text('Upload Image'),
                ),
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(
                      File(imagePath!),
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
                  if (menu != null) {
                    // Update existing menu
                    menu.name = nameController.text;
                    menu.price =
                        double.tryParse(priceController.text) ?? menu.price;
                    menu.points =
                        int.tryParse(pointsController.text) ?? menu.points;
                    menu.image = imagePath;
                  } else {
                    // Add new menu
                    menuItems.add(
                      Menu(
                        id: menuItems.length + 1,
                        name: nameController.text,
                        price: double.tryParse(priceController.text) ?? 0.0,
                        points: int.tryParse(pointsController.text) ?? 0,
                        createdAt: DateTime.now(),
                        image: imagePath,
                      ),
                    );
                  }
                });
                Navigator.pop(context);
              },
              child: Text(menu != null ? 'Save' : 'Add'),
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
      appBar: AppBar(
        title: const Text(
          'Menu Management',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child:
                          item.image != null && item.image!.contains('assets')
                              ? Image.asset(
                                  item.image!,
                                  fit: BoxFit.cover,
                                )
                              : item.image != null
                                  ? Image.file(
                                      File(item.image!),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/espresso.jpg',
                                      fit: BoxFit.cover,
                                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.price.toStringAsFixed(2)}DT',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Points: ${item.points}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonPadding: EdgeInsets.zero,
                    children: [
                      TextButton(
                        onPressed: () => _addOrEditMenuItem(menu: item),
                        child: const Text('Edit'),
                      ),
                      TextButton(
                        onPressed: () => _deleteMenuItem(item),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
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
              onPressed: () => _addOrEditMenuItem(),
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
