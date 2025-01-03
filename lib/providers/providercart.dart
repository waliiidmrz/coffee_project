import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Product product, int quantity, String size, String option) {
    final existingIndex =
        _cartItems.indexWhere((item) => item['product'] == product);

    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity'] += quantity;
    } else {
      _cartItems.add({
        'product': product,
        'quantity': quantity,
        'size': size,
        'option': option,
      });
    }
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    final index = _cartItems.indexWhere((item) => item['product'] == product);
    if (index != -1) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index]['quantity'] = quantity;
      }
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item['product'] == product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalAmount {
    return _cartItems.fold(
      0.0,
      (sum, item) => sum + (item['product'].price! * item['quantity']),
    );
  }
}
