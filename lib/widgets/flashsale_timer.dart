import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers.dart';

class FlashSaleTimer extends ConsumerWidget {
  const FlashSaleTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashSale = ref.watch(flashSaleProvider);

    if (!flashSale.hasValue || !(flashSale.value?["isActive"] ?? false)) {
      return const SizedBox(); // No Flash Sale Active
    }

    // ✅ Ensure Timestamp is Properly Converted to DateTime
    final Timestamp? firestoreTimestamp = flashSale.value?["endsAt"];
    if (firestoreTimestamp == null) {
      return const Center(child: Text("⏳ Sale End Time Not Found", style: TextStyle(color: Colors.red)));
    }

    final DateTime saleEndTime = firestoreTimestamp.toDate(); // ✅ Convert Firestore Timestamp to DateTime
    final Duration remainingTime = saleEndTime.difference(DateTime.now());

    // ✅ Ensure Sale Timer is Still Valid
    if (remainingTime.isNegative) {
      return const Center(child: Text("⏳ Flash Sale Ended", style: TextStyle(color: Colors.red)));
    }

    // Formatting the Countdown Timer
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          "Flash Sale Ends In: ${formatDuration(remainingTime)}",
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


