import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/product.dart';

/// 🔥 Firestore Flash Sale Status Provider
final flashSaleProvider = StreamProvider<Map<String, dynamic>>((ref) {
  return FirebaseFirestore.instance
      .collection("flash_sale")
      .doc("status")
      .snapshots()
      .map((doc) {
    if (!doc.exists) {
      print("⚠️ Firestore Flash Sale Document Not Found!");
      return {"isActive": false, "endsAt": null};
    }

    final data = doc.data();
    print("🔥 Firestore Flash Sale Data Loaded: $data");
    return data ?? {"isActive": false, "endsAt": null};
  });
});

/// 🔥 Firestore Products Provider
final productProvider = StreamProvider<List<Product>>((ref) {
  return FirebaseFirestore.instance
      .collection("products")
      .snapshots()
      .map((snapshot) {
    if (snapshot.docs.isEmpty) {
      print("⚠️ No Products Found in Firestore!");
      return [];
    }

    return snapshot.docs.map((doc) {
      final data = doc.data();
      print("📦 Firestore Product Loaded: ${doc.id} -> $data");

      // ✅ Use the corrected Product model
      return Product.fromJson(data, doc.id);
    }).toList();
  });
});
