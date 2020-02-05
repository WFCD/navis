import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EventVideoPlayer extends StatefulWidget {
  const EventVideoPlayer({Key key, @required this.videoID})
      : assert(videoID != null),
        super(key: key);

  final String videoID;

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<EventVideoPlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoID,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
