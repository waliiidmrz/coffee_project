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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/giftbg1.avif'), // Replace with your image
              fit: BoxFit.cover,
              opacity: 0.1),
        ),
        child: Center(
          child: Container(
            height: 250,
            width: 320,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color with opacity
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
                      height: 250,
                      width: 320,
                      child: const Image(
                        image: AssetImage('assets/images/giftcard.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                    bottom: 27,
                    right: 65,
                    child: Text(
                      '12/12/2024',
                      style: TextStyle(
                          color: Color.fromARGB(255, 192, 44, 34),
                          fontWeight: FontWeight.w500),
                    )),
                const Positioned(
                    top: 77,
                    right: 50,
                    child: Text(
                      '200.00 dt',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500),
                    )),
                const Positioned(
                    top: 133,
                    right: 35,
                    child: Text(
                      '06-99-48-18',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
