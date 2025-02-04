// first_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './second_screen.dart';

class FirstScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background image
          Image(
            image: const AssetImage('assets/images/bg-eid.jpg'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            color: const Color(0x33000000), // 0.2 opacity
            colorBlendMode: BlendMode.darken,
          ),
          // Centered input field
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.black,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: const Color(0xFFFFC107), // Pastel yellow
                      foregroundColor: Colors.white, // white text
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      shadowColor: Colors.amber.shade700,
                      elevation: 5,
                    ),
                    onPressed: () async {
                      if (nameController.text.isNotEmpty) {
                        // Save the user name in SharedPreferences
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('userName', nameController.text);
                        // Navigate to SecondScreen and replace the current screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondScreen(userName: nameController.text),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
