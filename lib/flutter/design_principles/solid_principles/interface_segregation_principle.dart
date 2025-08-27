import 'package:flutter/material.dart';

abstract class AudioPlayable {
  void playAudio();
}

abstract class VideoPlayable {
  void playVideo();
}

class AudioPlayer implements AudioPlayable {
  @override
  void playAudio() => print("Playing audio");
}

class VideoPlayer implements VideoPlayable, AudioPlayable {
  @override
  void playVideo() => print("Playing video");

  @override
  void playAudio() => print("Playing audio by video player");
}

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();

    return Card(
      child: ListTile(
        leading: const Icon(Icons.music_note),
        title: const Text("Audio Player"),
        trailing: ElevatedButton(
          onPressed: audioPlayer.playAudio,
          child: const Text("Play Audio"),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPlayer = VideoPlayer();

    return Card(
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.video_library),
            title: Text("Video Player"),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: videoPlayer.playVideo,
                child: const Text("Play Video"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: videoPlayer.playAudio,
                child: const Text("Play Audio"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ISPDemoApp()));
}

class ISPDemoApp extends StatelessWidget {
  const ISPDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interface Segregation (ISP)")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AudioPlayerWidget(),
            SizedBox(height: 24),
            VideoPlayerWidget(),
          ],
        ),
      ),
    );
  }
}
