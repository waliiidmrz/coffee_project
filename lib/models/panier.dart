import 'package:BISOU/models/product.dart';

class Panier {
  final int id;
  final List<PanierItem> products;
  final double totalAmount;

  Panier({
    required this.id,
    required this.products,
  }) : totalAmount = products.fold(
          0.0,
          (sum, item) => sum + item.totalPrice,
        );

  Map<String, dynamic> toMap() => {
        'id': id,
        'products': products.map((e) => e.toMap()).toList(),
        'totalAmount': totalAmount,
      };

  factory Panier.fromMap(Map<String, dynamic> map) => Panier(
        id: map['id'],
        products: List<PanierItem>.from(
          map['products']?.map((x) => PanierItem.fromMap(x)) ?? [],
        ),
      );
}

class PanierItem {
  final Product product;
  final int quantity;

  PanierItem({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toMap() => {
        'product': product.toMap(),
        'quantity': quantity,
      };

  factory PanierItem.fromMap(Map<String, dynamic> map) => PanierItem(
        product: Product.fromMap(map['product']),
        quantity: map['quantity'],
      );
}
