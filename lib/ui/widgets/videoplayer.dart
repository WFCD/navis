import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String lore;
  final String url;

  VideoPlayer({this.lore, this.url});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('http:${widget.url}');
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
      padding: EdgeInsets.all(20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: TextStyle(fontSize: 15)),
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
