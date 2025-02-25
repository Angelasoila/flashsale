/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../widgets/product_card.dart';
import '../widgets/flashsale_timer.dart';
import 'cart_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final flashSaleAsync = ref.watch(flashSaleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show Flash Sale Timer only if active
            flashSaleAsync.when(
              data: (flashSale) {
                if (flashSale["isActive"] == true) {
                  return const FlashSaleTimer();
                }
                return const SizedBox();
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text("Error loading flash sale: $error"),
            ),
            const SizedBox(height: 12),
            const Text(
              "Recommended Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Handle Product Loading, Error & Data
            Expanded(
              child: productsAsync.when(
                data: (products) {
                  if (products.isEmpty) {
                    return const Center(child: Text("No products available."));
                  }
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]); // ✅ Ensure correct data type
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text("Error loading products: $error")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../widgets/product_card.dart';
import '../widgets/flashsale_timer.dart';
import 'cart_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final flashSaleAsync = ref.watch(flashSaleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            flashSaleAsync.when(
              loading: () {
                print("⏳ Flash Sale Data is Loading...");
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, _) {
                print("❌ Firestore Error: $error");
                return Center(child: Text("Error: $error"));
              },
              data: (flashSaleData) {
                print("🔥 Flash Sale Timer Loaded: $flashSaleData");
                if (flashSaleData.isEmpty || flashSaleData["isActive"] == false) {
                  return const SizedBox(); // No sale active
                }
                return const FlashSaleTimer();
              },
            ),
            const SizedBox(height: 12),
            const Text(
              "Recommended Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: productsAsync.when(
                loading: () {
                  print("⏳ Products are Loading...");
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, _) {
                  print("❌ Product Load Error: $error");
                  return Center(child: Text("Error: $error"));
                },
                data: (products) {
                  print("✅ Products Loaded: ${products.length}");
                  if (products.isEmpty) {
                    return const Center(child: Text("No products available."));
                  }
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
