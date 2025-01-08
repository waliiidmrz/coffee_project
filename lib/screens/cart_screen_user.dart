import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providercart.dart';
import '../widgets/pay_button.dart';
import '../widgets/payment_summary_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider1>();
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(
                  context, '/home'); // Ensure fallback navigation
            }
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xff2F2D2C),
          ),
        ),
        title: const Text(
          "Your Cart",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff2F2D2C),
          ),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _buildCartList(cartItems, cartProvider),
                    const SizedBox(height: 20),
                    PaymentSummaryCard(), // Display payment summary
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: PayButton(
                          title: "Proceed to Checkout",
                          onPressed: () {
                            Navigator.pushNamed(context,
                                '/new-order'); // Adjust the route to your NewOrderScreen
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCartList(
      List<Map<String, dynamic>> cartItems, CartProvider1 cartProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Product Image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(item['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Product Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Size: ${item['size']}, Option: ${item['option']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff9B9B9B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Quantity Controls
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          cartProvider.updateQuantity(
                              item['name'], item['quantity'] - 1);
                        },
                      ),
                      Text(
                        "${item['quantity']}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          cartProvider.updateQuantity(
                              item['name'], item['quantity'] + 1);
                        },
                      ),
                    ],
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
