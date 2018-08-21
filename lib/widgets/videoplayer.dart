import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../services/state.dart';

class FishPlayer extends StatefulWidget {
  final String url;

  FishPlayer({this.url});

  @override
  _FishPlayer createState() => _FishPlayer();
}

class _FishPlayer extends State<FishPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network('https:${widget.url}');
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: SystemState.fishVideos(widget.url),
        builder: (context, snapshot) {
          return Container(
              child: Chewie(_controller,
                  autoInitialize: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  materialProgressColors: ChewieProgressColors(
                      backgroundColor: Colors.white,
                      bufferedColor: Colors.blue,
                      playedColor: Colors.blue,
                      handleColor: Colors.blue)));
        });
  }
}
