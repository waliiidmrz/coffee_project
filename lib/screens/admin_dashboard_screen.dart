import 'package:flutter/material.dart';
import '../widgets/menu_item_card.dart';
import '../screens/cart_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<Map<String, dynamic>> _cart = [];
  final Map<String, dynamic> _user = {
    'name': 'John Doe',
    'points': 150,
    'giftCard': '\$25',
    'profilePicture': 'https://via.placeholder.com/100',
  };

  double get _total =>
      _cart.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

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

  void _updateCartQuantity(int index, int quantity) {
    setState(() {
      if (quantity > 0) {
        _cart[index]['quantity'] = quantity;
      } else {
        _cart.removeAt(index);
      }
    });
  }

  void _removeItemFromCart(int index) {
    setState(() {
      _cart.removeAt(index);
    });
  }

  void _passOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order has been placed successfully!')),
    );

    setState(() {
      _cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFFC52127),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartItems: _cart,
                        updateCartQuantity: _updateCartQuantity,
                        passOrder: _passOrder,
                        removeItem: _removeItemFromCart,
                      ),
                    ),
                  ).then((_) => setState(() {})); // Update cart count
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Admin!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // User Profile Picture
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
            const Text(
              'Menu Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final name = 'Menu Item ${index + 1}';
                  final price = (index + 1) * 2.5;

                  return MenuItemCard(
                    name: name,
                    price: price,
                    onAddToCart: () => _addToCart(name, price),
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
