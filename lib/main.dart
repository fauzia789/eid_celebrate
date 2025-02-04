// main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/first_screen.dart';
import 'screens/second_screen.dart';
import 'services/notification-helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notifications
  await NotificationHelper.initializeNotifications();
  
  // Schedule the event notification if needed.
  // Set your event date here. For example, February 14, 2025.
  DateTime eventDate = DateTime(2025, 2, 14);
  if (eventDate.isAfter(DateTime.now())) {
    await NotificationHelper.scheduleNotification(eventDate);
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eid Celebration App',
      home: FutureBuilder<String?>(
        future: _getUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return SecondScreen(userName: snapshot.data!);
            } else {
              return FirstScreen();
            }
          }
        },
      ),
    );
  }
}
