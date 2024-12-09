import 'package:flutter/material.dart';

class GiftCardScreen extends StatelessWidget {
  final Map<String, dynamic> giftCard = {
    'balance': 50, // Ensure this is a numeric value (int or String)
    'cardNumber': '1234-5678-9012-3456',
    'expiryDate': '12/2025',
  };

  double _parseBalance(dynamic balance) {
    if (balance is double) {
      return balance;
    } else if (balance is int) {
      return balance.toDouble();
    } else if (balance is String) {
      return double.tryParse(balance) ?? 0.0;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final double balance =
        _parseBalance(giftCard['balance']); // Safely parse balance

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Card'),
        backgroundColor: const Color(0xFFC52127),
      ),
      body: Container(
        color: const Color(0xFFF5F5F5), // Light background
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gift Card Display
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC52127),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Gift Card Balance',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '\$${balance.toStringAsFixed(2)}', // Safely display the balance
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Card Number: ${giftCard['cardNumber']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'Expiry Date: ${giftCard['expiryDate']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Redeem Button
                ElevatedButton(
                  onPressed: () {
                    // Handle redeem action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC52127),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Redeem Balance',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
