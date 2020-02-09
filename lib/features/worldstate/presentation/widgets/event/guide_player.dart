import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO: Find more how-to guides for events might be slightly annoying older events
class EventVideoPlayer extends StatefulWidget {
  const EventVideoPlayer({
    Key key,
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.profileThumbnail,
    @required this.link,
  })  : assert(id != null),
        super(key: key);

  final String id;
  final String title;
  final String author;
  final String profileThumbnail;
  final String link;

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<EventVideoPlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          YoutubePlayer(controller: _controller),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.subhead,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 10.0,
                      backgroundImage:
                          CachedNetworkImageProvider(widget.profileThumbnail),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.author,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () => launch(widget.link),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
