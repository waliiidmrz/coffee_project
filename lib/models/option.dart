class Option {
  final int id;
  final String name;
  final String optionType; // Example: "Size", "Topping"
  final List<int>
      applicableProductIds; // List of product IDs this option applies to

  Option({
    required this.id,
    required this.name,
    required this.optionType,
    this.applicableProductIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'optionType': optionType,
        'applicableProductIds': applicableProductIds,
      };

  factory Option.fromMap(Map<String, dynamic> map) => Option(
        id: map['id'],
        name: map['name'],
        optionType: map['optionType'],
        applicableProductIds: List<int>.from(map['applicableProductIds'] ?? []),
      );
}
