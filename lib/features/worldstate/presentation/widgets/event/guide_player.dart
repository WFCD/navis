import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

// TODO: Find more how-to guides for events might be slightly annoying for older events
// TODO: Make sure this setup works for all events
// TODO: find a way to adapt a stream to network speed, might come later with Youtube_explode
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
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _setupPlayer();
  }

  Future<void> _setupPlayer() async {
    final exploded = yt.YoutubeExplode();
    final videoMediaInfo = await exploded.getVideoMediaStream(widget.id);

    if (mounted) {
      final video = videoMediaInfo.muxed.firstWhere((v) =>
          v.videoQuality == yt.VideoQuality.high1080 ||
          v.videoQuality == yt.VideoQuality.high720);

      setState(() {
        _videoPlayerController =
            VideoPlayerController.network(video.url.toString());

        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio:
              video.videoResolution.width / video.videoResolution.height,
          autoInitialize: true,
          showControlsOnInitialize: false,
          materialProgressColors: ChewieProgressColors(
            playedColor: Theme.of(context).accentColor,
            bufferedColor: Colors.grey[400],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        height: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_chewieController == null)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Chewie(controller: _chewieController),
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
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
