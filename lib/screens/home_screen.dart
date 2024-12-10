import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'GiftCardScreen.dart';
import 'My_Orders.dart';
import 'ProfileScreen.dart';
import 'ProductDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _selectedFilter = 'All';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeContent(
            products: products,
            selectedFilter: _selectedFilter,
            onFilterChange: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),
          MyOrdersScreen(),
          GiftCardScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFC52127),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Icon(Icons.card_giftcard),
            label: 'Gift Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Product> products;
  final String selectedFilter;
  final ValueChanged<String> onFilterChange;

  const HomeContent({
    Key? key,
    required this.products,
    required this.selectedFilter,
    required this.onFilterChange,
  }) : super(key: key);

  List<Product> get filteredProducts {
    if (selectedFilter == 'All') {
      return products;
    } else if (selectedFilter == 'Promo') {
      return products.where((p) => p.isPromo).toList();
    } else if (selectedFilter == 'Best Sale') {
      return products.take(3).toList();
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Title and Search Bar
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
          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterButton(
                  label: 'All',
                  isActive: selectedFilter == 'All',
                  onTap: () => onFilterChange('All'),
                ),
                FilterButton(
                  label: 'Promo',
                  isActive: selectedFilter == 'Promo',
                  onTap: () => onFilterChange('Promo'),
                ),
                FilterButton(
                  label: 'Best Sale',
                  isActive: selectedFilter == 'Best Sale',
                  onTap: () => onFilterChange('Best Sale'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  product: product,
                  onAddToCart: () => print('${product.name} added to cart'),
                  onViewDetails: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FilterButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? const Color(0xFFC52127) : Colors.white,
        side: const BorderSide(color: Color(0xFFC52127)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : const Color(0xFFC52127),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
