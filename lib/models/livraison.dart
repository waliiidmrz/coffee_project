import 'package:BISOU/models/panier.dart';

class Livraison {
  final int id;
  final String deliveryAddress;
  final DateTime deliveryDate;
  final String status; // Example: "Pending", "Shipped", "Delivered"
  final int userId;
  final Panier panier; // Associated Panier (Cart) for this delivery

  Livraison({
    required this.id,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.status,
    required this.userId,
    required this.panier,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'deliveryAddress': deliveryAddress,
        'deliveryDate': deliveryDate.toIso8601String(),
        'status': status,
        'userId': userId,
        'panier': panier.toMap(), // Include the Panier details
      };

  factory Livraison.fromMap(Map<String, dynamic> map) => Livraison(
        id: map['id'],
        deliveryAddress: map['deliveryAddress'],
        deliveryDate: DateTime.parse(map['deliveryDate']),
        status: map['status'],
        userId: map['userId'],
        panier: Panier.fromMap(map['panier']), // Parse the Panier
      );
}
