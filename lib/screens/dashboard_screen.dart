import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart_provider.dart';
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
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 Flash Sale Timer
            flashSaleAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text("Error: $error")),
              data: (flashSaleData) {
                if (flashSaleData["isActive"] == false) {
                  return const SizedBox(); // No sale active
                }

                final DateTime? endsAt = flashSaleData["endsAt"];
                if (endsAt == null) return const SizedBox();

                return FlashSaleTimer(endsAt: endsAt); // ✅ Show Live Countdown
              },
            ),
            const SizedBox(height: 12),

            /// 🏷 Recommended Products
            const Text("Recommended Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            /// 🛒 Product List
            Expanded(
              child: productsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text("Error: $error")),
                data: (products) {
                  if (products.isEmpty) {
                    return const Center(child: Text("No products available."));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // ✅ Fit 3 cards per row
                      childAspectRatio: 0.75, // ✅ Adjust height for better layout
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: products[index],
                        onAddToCart: () {
                          ref.read(cartProvider.notifier).addToCart(products[index]);
                        },
                      );
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
