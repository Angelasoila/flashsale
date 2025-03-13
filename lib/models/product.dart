class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final int discountPercentage;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discountPercentage,
  });

  /// ✅ Calculate Sale Price Dynamically
  double get salePrice => price * (1 - (discountPercentage / 100));

  /// ✅ Convert Firestore JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id,
      name: json["name"] ?? "Unknown",
      image: json["image"] ?? "assets/images/placeholder.jpg",
      price: (json["price"] as num?)?.toDouble() ?? 0.0,  // Ensures conversion safety
      discountPercentage: (json["discountPercentage"] as num?)?.toInt() ?? 0, // Ensures conversion safety
    );
  }
}

