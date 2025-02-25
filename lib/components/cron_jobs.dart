import 'package:cron/cron.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void startFlashSaleCronJobs() {
  final cron = Cron();

  /// Start Flash Sale Every Day at 6 PM
  cron.schedule(Schedule.parse('0 18 * * *'), () async {
    await FirebaseFirestore.instance.collection("flash_sale").doc("status").set({
      "isActive": true,
      "endsAt": DateTime.now().add(const Duration(minutes: 30)),
    });

    // Activate flash sale for products
    final products = await FirebaseFirestore.instance.collection("products").get();
    for (var doc in products.docs) {
      await doc.reference.update({"isFlashSale": true});
    }
    print("🔥 Flash Sale Started!");
  });

  /// End Flash Sale After 30 Minutes
  cron.schedule(Schedule.parse('30 18 * * *'), () async {
    await FirebaseFirestore.instance.collection("flash_sale").doc("status").set({
      "isActive": false,
    });

    // Deactivate flash sale for products
    final products = await FirebaseFirestore.instance.collection("products").get();
    for (var doc in products.docs) {
      await doc.reference.update({"isFlashSale": false});
    }
    print("⏳ Flash Sale Ended!");
  });
}
