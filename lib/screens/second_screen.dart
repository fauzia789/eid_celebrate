// second_screen.dart
import 'package:flutter/material.dart';
import './third_screen.dart';

class SecondScreen extends StatelessWidget {
  final String userName;

  const SecondScreen({required this.userName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Eid!'),
        backgroundColor: Colors.amber.shade400, 
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF9C4),
              Color(0xFFCFD8DC), 
              Color(0xFFECE0D1), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gradient Text Effect
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.brown, Colors.black87],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  '🎉 May your Eid be filled with joy, peace, and blessings, $userName! 🎉',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, 
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20.0),
              // Button to go to ThirdScreen (Activities)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.amber.shade500,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThirdScreen()),
                  );
                },
                child: const Text('Go to Activities'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
