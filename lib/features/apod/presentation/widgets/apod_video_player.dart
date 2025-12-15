import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ApodVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ApodVideoPlayer({super.key, required this.videoUrl});

  @override
  State<ApodVideoPlayer> createState() => _ApodVideoPlayerState();
}

class _ApodVideoPlayerState extends State<ApodVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    // 1. Extract Video ID from the URL (e.g. "CC7OJ7gFLvE")
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    // 2. Initialize the Controller
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '', // Handle potential null ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If we couldn't parse the video ID, show an error or placeholder
    if (_controller.initialVideoId.isEmpty) {
      return Container(
        height: 350,
        color: Colors.black,
        child: const Center(
          child: Text("Could not load video", style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return YoutubePlayerBuilder(
      // This builder handles Fullscreen mode automatically
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.deepPurple,
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
        return SizedBox(
          height: 350, // Match your image height
          width: double.infinity,
          child: player,
        );
      },
    );
  }
}