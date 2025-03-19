import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    print("🖼 Rendering: ${product.name}, Price: \$${product.price}, Discount: ${product.discountPercentage}%, Sale Price: \$${product.salePrice}");

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼 Product Image
          AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
              },
            ),
          ),

          // ℹ️ Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📛 Product Name
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                const SizedBox(height: 6),

                // 💰 Price Display
                Row(
                  children: [
                    // 🔥 Discounted Price (always shown)
                    Text(
                      "\$${product.salePrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(width: 6),

                    // ⛔ Strikethrough Original Price (only if discount exists)
                    if (product.discountPercentage > 0)
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 6),

                // 🛒 Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    icon: const Icon(Icons.shopping_cart, size: 14),
                    label: const Text("Add", style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
