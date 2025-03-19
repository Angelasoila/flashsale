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
  double get salePrice {
    if (discountPercentage > 0) {
      return price - (price * discountPercentage / 100);
    }
    return price;
  }

  /// ✅ Convert Firestore JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json, String id) {
    // Parse fields with null safety and default values
    final discount = (json["discountPercentage"] as num?)?.toInt() ?? 0;
    final price = (json["price"] as num?)?.toDouble() ?? 0.0;

    final product = Product(
      id: id,
      name: json["name"] ?? "Unknown",
      image: json["image"] ?? "assets/images/placeholder.jpg",
      price: price,
      discountPercentage: discount,
    );

    // 🔍 Debugging: Print product details when it's created
    print("✅ Product Loaded: ${product.name}, Price: \$${product.price}, Discount: ${product.discountPercentage}%, Sale Price: \$${product.salePrice}");

    return product;
  }
}


