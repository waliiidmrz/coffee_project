import 'package:BISOU/models/option.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId; // ID of the category it belongs to
  final bool isPromo; // Indicates if the product is on promotion
  final List<Option> options; // List of options for the product

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.isPromo = false,
    this.options = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'categoryId': categoryId,
        'isPromo': isPromo,
        'options': options.map((e) => e.toMap()).toList(),
      };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: map['price'],
        categoryId: map['categoryId'],
        imageUrl: map['imageUrl'],
        isPromo: map['isPromo'] ?? false,
        options: List<Option>.from(
          map['options']?.map((x) => Option.fromMap(x)) ?? [],
        ),
      );
}
