import 'package:coffee_project/screens/ProductDetailsScreen.dart';
import 'package:flutter/material.dart';
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

  final Map<String, dynamic> _user = {
    'name': 'John Doe',
    'points': 150,
    'giftCard': '\$25',
    'profilePicture': 'https://via.placeholder.com/100',
  };

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

  void _addToCart(String name, double price, int quantity) {
    setState(() {
      final existingItem = _cart.firstWhere(
        (item) => item['name'] == name,
        orElse: () => {'name': '', 'price': 0.0, 'quantity': 0},
      );

      if (existingItem['name'] == name) {
        existingItem['quantity'] += quantity;
      } else {
        _cart.add({'name': name, 'price': price, 'quantity': quantity});
      }
    });
  }

  List<Product> getFilteredProducts(int categoryIndex) {
    if (categoryIndex == 0) return products;
    return products; // For now, returning all products
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
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
                        removeItem: (index) {
                          setState(() {
                            _cart.removeAt(index);
                          });
                        },
                        clearGlobalCart: () {
                          setState(() {
                            _cart
                                .clear(); // Clear the global cart in the dashboard
                          });
                        },
                        userName: _user['name'], // Pass user name
                        userProfilePicture:
                            _user['profilePicture'], // Pass profile picture
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
              'Welcome!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            // User Card
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _user['profilePicture'],
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _user['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Points: ${_user['points']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Gift Card: ${_user['giftCard']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: selectedCategory == index
                              ? Colors.blue
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: selectedCategory == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Products Grid
            Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding around the GridView
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: getFilteredProducts(selectedCategory).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = getFilteredProducts(selectedCategory)[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetail(
                            product: product,
                            onAddToCart: _addToCart,
                          ),
                        ),
                      );
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
                          // Product Image
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                product.imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          // Product Name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          // Product Price
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$${product.price!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // Add to Cart Button
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: ElevatedButton(
                              onPressed: () => _addToCart(
                                product.name!,
                                product.price!,
                                1,
                              ),
                              child: const Text('Add to Cart'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
