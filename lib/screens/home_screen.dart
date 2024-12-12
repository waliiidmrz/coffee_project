import 'package:coffee_project/providers/provider.dart';
import 'package:coffee_project/widgets/custo_sidebar.dart';
import 'package:coffee_project/widgets/custom_appbar.dart';
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
      appBar: const CustomAppBar(title: 'Bisou'),
      endDrawer: const CustomSidebar(),
      body: Column(
        children: [
          // Header and Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.candlestick_chart_outlined),
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
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, bottom: 5),
            child: Container(
              height: 150,
              width: 500,
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.grey[200]!.withOpacity(.6),
                        height: 141,
                        width: 250,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 80,
                    child: Image.asset(
                      'assets/images/breakfast.png',
                      width: 150,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Colors.white,
                        child: const Text(
                          '  PROMO  ',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 40,
                    top: 40,
                    child: Text(
                      'Petit Déj ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 60,
                    child: Text(
                      'Bisou',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          color: Colors.grey.withOpacity(.7)),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
