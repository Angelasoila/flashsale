import 'package:flutter/material.dart';
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
}
