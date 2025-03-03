import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final List<Map<String, String>> items = List.generate(
    10,
    (index) => {
      'icon': 'assets/images/color_placeholder_${index + 1}.png',
      'text': 'Item ${index + 1}',
      'sound': 'assets/audio/eid${index + 1}.mp3',
    },
  );

  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _playingIndex; 
  @override
  void initState() {
    super.initState();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() => _playingIndex = null);
      }
    });
  }

  Future<void> _playOrPause(int index) async {
    if (_playingIndex == index) {
      await _audioPlayer.stop();
      setState(() => _playingIndex = null);
    } else {
      try {
        await _audioPlayer.setAsset(items[index]['sound']!);
        await _audioPlayer.play();
        setState(() => _playingIndex = index);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error playing sound: ${e.toString()}')),
        );
      }
    }
  }

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFFFEB3B),
                  backgroundImage: AssetImage(items[index]['icon']!),
                ),
                title: Text(
                  items[index]['text']!,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                trailing: IconButton(
                  icon: Icon(
                    _playingIndex == index ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xFFFFEB3B),
                  ),
                  onPressed: () => _playOrPause(index),
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
