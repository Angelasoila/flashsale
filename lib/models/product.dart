class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final double salePrice;
  final bool isFlashSale;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.salePrice,
    required this.isFlashSale,
  });

  /// ✅ Converts Firestore JSON into Product object
  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id, // ✅ Firestore `id` comes from `doc.id`
      name: json["name"] ?? "Unknown",
      image: json["image"] ?? "",
      price: (json["price"] ?? 0).toDouble(),
      salePrice: (json["salePrice"] ?? 0).toDouble(),
      isFlashSale: json["isFlashSale"] ?? false,
    );
  }
}
