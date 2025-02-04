import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  // List of items with colors and sounds
  final List<Map<String, String>> items = List.generate(
    10, // Now we have 10 items
    (index) => {
      'icon': 'assets/images/color_placeholder_${index + 1}.png',
      'text': 'Item ${index + 1}',
      'sound': 'assets/audio/eid${index + 1}.mp3',
    },
  );

  // Initialize the audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  
  int? _playingIndex;
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
        backgroundColor: const Color(0xFFBDBDBD), 
      ),
      body: Container(
        color: const Color(0xFFF5F5F5), 
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white, 
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), 
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFEB3B), 
                  ),
                  child: const Icon(Icons.circle, color: Colors.black),
                ),
                title: Text(
                  items[index]['text']!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, 
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    _isPlaying && _playingIndex == index
                        ? Icons.pause 
                        : Icons.play_arrow, 
                    color: Color(0xFFFFEB3B), 
                  ),
                  onPressed: () async {
                    if (_isPlaying && _playingIndex == index) {
                      // If the audio is currently playing, stop it
                      await _audioPlayer.stop();
                      setState(() {
                        _isPlaying = false;
                        _playingIndex = null; 
                      });
                    } else {
                      try {
                        
                        await _audioPlayer.setAsset(
                          items[index]['sound']!,
                        );
                        _audioPlayer.play();
                        setState(() {
                          _isPlaying = true;
                          _playingIndex = index; 
                        });
                      } catch (e) {
                        // Show error if audio fails to play
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error playing sound: ${e.toString()}'),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
   
    _audioPlayer.dispose();
    super.dispose();
  }
}
