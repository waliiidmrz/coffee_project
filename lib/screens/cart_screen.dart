import 'package:flutter/material.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final void Function(int index, int quantity) updateCartQuantity;
  final VoidCallback passOrder;
  final void Function(int index) removeItem;

  const CartScreen({
    Key? key,
    required this.cartItems,
    required this.updateCartQuantity,
    required this.passOrder,
    required this.removeItem,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalAmount => widget.cartItems.fold(
        0,
        (sum, item) => sum + (item['price'] * item['quantity']),
      );

  void _updateQuantity(int index, int quantity) {
    widget.updateCartQuantity(index, quantity);
    setState(() {}); // Trigger UI update for total price
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return Dismissible(
                    key: Key(item['name']),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      widget.removeItem(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item['name']} removed from cart'),
                        ),
                      );
                      setState(() {});
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: CartItemCard(
                      item: item,
                      onAdd: () => _updateQuantity(index, item['quantity'] + 1),
                      onRemove: () =>
                          _updateQuantity(index, item['quantity'] - 1),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC52127),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.passOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC52127),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
