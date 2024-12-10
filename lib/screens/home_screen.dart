import 'package:coffee_project/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'ProductDetailsScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> products = [
    Product(
        name: 'Espresso',
        price: 2.99,
        imageUrl: 'assets/images/espresso.png',
        isPromo: true),
    Product(
        name: 'Cappuccino',
        price: 3.49,
        imageUrl: 'assets/images/cappuccino.png',
        isPromo: false),
    Product(
        name: 'Latte',
        price: 3.99,
        imageUrl: 'assets/images/latte.png',
        isPromo: true),
    Product(
        name: 'Mocha',
        price: 4.29,
        imageUrl: 'assets/images/mocha.png',
        isPromo: false),
    Product(
        name: 'Macchiato',
        price: 3.79,
        imageUrl: 'assets/images/macchiato.png',
        isPromo: true),
    Product(
        name: 'Americano',
        price: 2.89,
        imageUrl: 'assets/images/americano.png',
        isPromo: false),
  ];

  List<Product> getFilteredProducts(String filter) {
    if (filter == 'All') return products;
    if (filter == 'Promo') return products.where((p) => p.isPromo).toList();
    return products;
  }

  @override
  Widget build(BuildContext context) {
    String selectedFilter = 'All';

    return Scaffold(
      body: Column(
        children: [
          // Header and Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for beverages or foods',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Product Grid
          Expanded(
            child: GridView.builder(
              itemCount: getFilteredProducts(selectedFilter).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = getFilteredProducts(selectedFilter)[index];
                return ProductCard(
                  product: product,
                  onAddToCart: () {
                    context.read<CartProvider>().addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart')),
                    );
                  },
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
