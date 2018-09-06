import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FishPlayer extends StatefulWidget {
  final String url;

  FishPlayer({this.url});

  @override
  _FishPlayer createState() => _FishPlayer();
}

class _FishPlayer extends State<FishPlayer>
    with SingleTickerProviderStateMixin {
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
    return Container(
        child: Chewie(
          _controller,
          autoInitialize: true,
          autoPlay: true,
          aspectRatio: 3 / 2,
          showControls: true,
          materialProgressColors: ChewieProgressColors(
              playedColor: Colors.blue,
              backgroundColor: Colors.grey,
              handleColor: Colors.white,
              bufferedColor: Colors.white),
        ));
  }
}
