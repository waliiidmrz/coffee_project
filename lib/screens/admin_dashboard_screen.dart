import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../models/product.dart';
import 'cart_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<Map<String, dynamic>> _cart = [];
  int selectedCategory = 0;

  final List<String> categories = [
    'Coffee',
    'Iced',
    'Juices',
    'Breakfast',
    'Sandwiches',
    'Salads',
    'Plates',
    'Teas',
    'Shakes',
    'Sides'
  ];

  final List<Product> products = [
    Product(
      name: 'Espresso',
      price: 2.99,
      imageUrl: 'assets/images/express.jpeg',
      isPromo: true,
    ),
    Product(
      name: 'Cappuccino',
      price: 3.49,
      imageUrl: 'assets/images/cappucino.jpeg',
      isPromo: false,
    ),
    Product(
      name: 'Latte',
      price: 3.99,
      imageUrl: 'assets/images/latte.jpeg',
      isPromo: true,
    ),
    Product(
      name: 'Mocha',
      price: 4.29,
      imageUrl: 'assets/images/latte.webp',
      isPromo: false,
    ),
    Product(
      name: 'Macchiato',
      price: 3.79,
      imageUrl: 'assets/images/macchiato.jpg',
      isPromo: true,
    ),
    Product(
      name: 'Americano',
      price: 2.89,
      imageUrl: 'assets/images/americano.jpeg',
      isPromo: false,
    ),
  ];

  void _addToCart(String name, double price) {
    setState(() {
      final existingItem = _cart.firstWhere(
        (item) => item['name'] == name,
        orElse: () => {'name': '', 'price': 0.0, 'quantity': 0},
      );

      if (existingItem['name'] == name) {
        existingItem['quantity'] += 1;
      } else {
        _cart.add({'name': name, 'price': price, 'quantity': 1});
      }
    });
  }

  List<Product> getFilteredProducts(int categoryIndex) {
    // Example: Filter logic can be based on the category
    if (categoryIndex == 0) return products; // Show all products
    return products; // For now, return all products as no specific filter logic is given
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.white,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartItems: _cart,
                        updateCartQuantity: (index, quantity) {
                          setState(() {
                            if (quantity > 0) {
                              _cart[index]['quantity'] = quantity;
                            } else {
                              _cart.removeAt(index);
                            }
                          });
                        },
                        passOrder: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed successfully!'),
                            ),
                          );
                          setState(() {
                            _cart.clear();
                          });
                        },
                        removeItem: (index) {
                          setState(() {
                            _cart.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_cart.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Welcome, Admin!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            // Categories List
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryItem(
                      index: index,
                      title: categories[index],
                      selectedCategory: selectedCategory,
                      onClick: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Products Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getFilteredProducts(selectedCategory).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = getFilteredProducts(selectedCategory)[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                      ),
                    );
                    _addToCart(product.name, product.price);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
