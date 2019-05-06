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
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoInitialize: true,
      autoPlay: true,
      aspectRatio: 3 / 2,
      showControls: true,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
