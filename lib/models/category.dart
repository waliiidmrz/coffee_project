import 'package:BISOU/models/product.dart';

class Category {
  final int id;
  final String name;
  final String categoryType; // Example: "Beverage", "Food", "Dessert"
  final List<Product> products;

  Category({
    required this.id,
    required this.name,
    required this.categoryType,
    this.products = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'categoryType': categoryType,
        'products': products.map((e) => e.toMap()).toList(),
      };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map['id'],
        name: map['name'],
        categoryType: map['categoryType'],
        products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x)) ?? [],
        ),
      );
}
