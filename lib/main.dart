/*import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/cron_jobs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print("🔔 Notification Permission: ${settings.authorizationStatus}");
// Subscribe to Flash Sale Notifications
  messaging.subscribeToTopic("flash_sale");

  startFlashSaleCronJobs(); // Start automated Flash Sale scheduler

  runApp(const ProviderScope(child: FlashSaleApp()));
}

class FlashSaleApp extends StatelessWidget {
  const FlashSaleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Sale',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const DashboardScreen(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ✅ Import Riverpod
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      const ProviderScope(child: FlashSaleApp())); // ✅ Add ProviderScope here
}

class FlashSaleApp extends StatelessWidget {
  const FlashSaleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Sale',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const DashboardScreen(),
    );
  }
}
