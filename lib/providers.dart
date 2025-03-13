import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/product.dart';

/// 🔥 Firestore Flash Sale Status Provider (Live Updates)
final flashSaleProvider = StreamProvider<Map<String, dynamic>>((ref) {
  return FirebaseFirestore.instance
      .collection("flash_sale")
      .doc("status")
      .snapshots()
      .map((doc) {
    if (!doc.exists || doc.data() == null) {
      print("⚠️ Firestore Flash Sale Document Not Found!");
      return {"isActive": false, "endsAt": null};
    }

    final data = doc.data()!;
    print("🔥 Firestore Flash Sale Data Loaded: $data");

    return {
      "isActive": data["isActive"] ?? false,
      "endsAt": (data["endsAt"] is Timestamp)
          ? (data["endsAt"] as Timestamp).toDate() // ✅ Convert Firestore Timestamp to DateTime
          : null,
    };
  });
});

/// 🛒 Firestore Products Provider (Live Product Updates)
final productProvider = StreamProvider<List<Product>>((ref) {
  return FirebaseFirestore.instance.collection("products").snapshots().map((snapshot) {
    if (snapshot.docs.isEmpty) {
      print("⚠️ No Products Found in Firestore!");
      return [];
    }

    return snapshot.docs.map((doc) {
      final data = doc.data();
      print("📦 Firestore Product Loaded: ${doc.id} -> $data");

      // ✅ Ensure all fields have proper types and defaults
      return Product(
        id: doc.id, // ✅ Firestore document ID
        name: data["name"] ?? "Unknown Product",
        price: (data["price"] ?? 0).toDouble(),
        image: data["image"] ?? "", 
        discountPercentage: (data["discount"] ?? 0).toInt(),
      );
    }).toList();
  });
});
