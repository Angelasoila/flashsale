import 'dart:convert';
import 'package:flutter/services.dart';

/// 🔄 Simulated API fetch (replace with actual API call)
Future<List<dynamic>> fetchProductsFromAPI() async {
  await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

  // Simulated JSON response (Replace this with an actual API request)
  String response = await rootBundle.loadString('assets/data/products.json');
  return jsonDecode(response); // Convert JSON string to List<dynamic>
}
