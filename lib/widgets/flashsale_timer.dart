import 'dart:async';
import 'package:flutter/material.dart';

class FlashSaleTimer extends StatefulWidget {
  final DateTime endsAt;

  const FlashSaleTimer({super.key, required this.endsAt});

  @override
  _FlashSaleTimerState createState() => _FlashSaleTimerState();
}

class _FlashSaleTimerState extends State<FlashSaleTimer> {
  late Duration remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _startCountdown();
  }

  void _updateRemainingTime() {
    setState(() {
      remainingTime = widget.endsAt.difference(DateTime.now());
    });
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime();
      if (remainingTime.isNegative) {
        timer.cancel();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (remainingTime.isNegative) return const SizedBox(); // Sale ended

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.red.shade400,
      child: Center(
        child: Text("⏳ Sale Ends in:  ${remainingTime.inDays} Days: ${remainingTime.inHours.remainder(24)} hrs: ${remainingTime.inMinutes.remainder(60)} min: ${remainingTime.inSeconds.remainder(60)} sec",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


