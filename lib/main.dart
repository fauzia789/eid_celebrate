import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/first_screen.dart';
import 'screens/second_screen.dart';
import 'services/notification-helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeApp();
  
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  try {
    // Initialize notifications
    await NotificationHelper.initializeNotifications();

    // Schedule event notification if the event is in the future
    DateTime eventDate = DateTime(2025, 2, 14);
    if (eventDate.isAfter(DateTime.now())) {
      await NotificationHelper.scheduleNotification(eventDate);
    }
  } catch (e) {
    debugPrint("Error initializing app: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _getUserName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userName') ?? ''; 
    } catch (e) {
      debugPrint("Error fetching user name: $e");
      return ''; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eid Celebration App',
      home: FutureBuilder<String>(
        future: _getUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          
          String userName = snapshot.data ?? '';
          return userName.isNotEmpty ? SecondScreen(userName: userName) : const FirstScreen();
        },
      ),
    );
  }
}
