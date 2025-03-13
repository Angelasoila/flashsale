/*import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200], // Placeholder for image
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  product.name.substring(0, 1), // First letter as placeholder
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("\$${product.salePrice}", 
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              if (product.isFlashSale)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("\$${product.price}",
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}*/

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
    double discountedPrice = product.price * (1 - (product.discountPercentage / 100));

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼 Image
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
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 6),

                // 🏷 Price Display
                Row(
                  children: [
                    // 🔥 Discounted Price
                    Text(
                      "\$${discountedPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 6),

                    // ⛔ Strikethrough Original Price (Only if Discounted)
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
                    onPressed: () {
                      if (onAddToCart != null) {
                        onAddToCart!();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Product added to cart!")),
                        );
                      }
                    },
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






