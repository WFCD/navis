import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({this.lore, this.url});

  final String lore;
  final String url;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
            builder: (_) => _buildPlayer(_controller, widget.lore, context)));
  }
}

Widget _buildPlayer(
    VideoPlayerController controller, String title, BuildContext context) {
  return Padding(
      padding: EdgeInsets.zero,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: const TextStyle(fontSize: 15)),
            ),
            Container(
                child: Chewie(
              controller,
              autoInitialize: true,
              autoPlay: true,
              aspectRatio: 3 / 2,
              showControls: true,
            ))
          ]));
}
