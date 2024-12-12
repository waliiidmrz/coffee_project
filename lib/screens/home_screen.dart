import 'package:coffee_project/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custo_sidebar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/category_item.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'ProductDetailsScreen.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  List<String> list = [
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
        isPromo: true),
    Product(
        name: 'Cappuccino',
        price: 3.49,
        imageUrl: 'assets/images/cappucino.jpeg',
        isPromo: false),
    Product(
        name: 'Latte',
        price: 3.99,
        imageUrl: 'assets/images/latte.jpeg',
        isPromo: true),
    Product(
        name: 'Mocha',
        price: 4.29,
        imageUrl: 'assets/images/latte.webp',
        isPromo: false),
    Product(
        name: 'Macchiato',
        price: 3.79,
        imageUrl: 'assets/images/macchiato.jpg',
        isPromo: true),
    Product(
        name: 'Americano',
        price: 2.89,
        imageUrl: 'assets/images/americano.jpeg',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for coffees or foods',
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
            ),
            const SizedBox(
              height: 10,
            ),
            // Categories List
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
              child: SizedBox(
                height: 40, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return CategoryItem(
                      index: index,
                      title: list[index],
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
            // Promo Section
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 0, bottom: 5),
              child: Container(
                height: 150,
                width: 300,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.1), // Shadow color with opacity
                      blurRadius: 8, // Blur intensity
                      offset: const Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey[200]!.withOpacity(.6),
                          height: 140,
                          width: 300,
                          child: const Image(
                            image: AssetImage('assets/images/restau.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: -3,
                        right: 0,
                        child: Image.asset(
                          'assets/images/promo.png',
                          width: 85,
                        )),
                    Positioned(
                      top: 50,
                      right: 35,
                      child: Image.asset(
                        'assets/images/breakfast.png',
                        width: 160,
                      ),
                    ),
                    const Positioned(
                      left: 90,
                      top: 18,
                      child: Text(
                        'Petit Déj ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: 'Countryside'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Products Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getFilteredProducts(selectedFilter).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = getFilteredProducts(selectedFilter)[index];
                return Item(
                  product: product,
                  /* onAddToCart: () {
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
                  },*/
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
