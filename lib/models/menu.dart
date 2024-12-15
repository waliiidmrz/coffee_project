class Menu {
  final int id; // Unique ID for the menu item
  String name; // Name of the menu item
  double price; // Price of the menu item
  int points; // Points awarded for purchasing the item
  final DateTime createdAt; // Timestamp of when the item was created
  final bool canDelete; // Flag to indicate if the item can be deleted
  final bool isDefault; // Flag to indicate if it's a default item
  String? image; // Path or URL to the item's image

  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.points,
    required this.createdAt,
    this.canDelete = true,
    this.isDefault = false,
    this.image,
  });

  // Method to convert a Menu object to a Map (for storage or API calls)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'points': points,
      'createdAt': createdAt.toIso8601String(),
      'canDelete': canDelete,
      'isDefault': isDefault,
      'image': image,
    };
  }

  // Factory constructor to create a Menu object from a Map
  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      points: map['points'],
      createdAt: DateTime.parse(map['createdAt']),
      canDelete: map['canDelete'] ?? true,
      isDefault: map['isDefault'] ?? false,
      image: map['image'],
    );
  }
}
