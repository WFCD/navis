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
  bool _isPlaying = true;
  FadeAnimation imageFadeAnim =
  FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https:${widget.url}')
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.play();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          if (!_controller.value.initialized) {
            return;
          }
          if (_controller.value.isPlaying) {
            imageFadeAnim =
                FadeAnimation(child: Icon(Icons.pause, size: 100.0));
            _controller.pause();
          } else {
            imageFadeAnim =
                FadeAnimation(child: Icon(Icons.play_arrow, size: 100.0));
            _controller.play();
          }
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: new VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
        ),
      ),
      Center(child: imageFadeAnim),
      Center(
          child: _controller.value.isBuffering
              ? const CircularProgressIndicator()
              : null),
    ];

    return Center(
        child: _controller.value.initialized
            ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(fit: StackFit.passthrough, children: children))
            : Container());
  }
}

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeAnimation(
      {this.child, this.duration: const Duration(milliseconds: 1000)});

  @override
  _FadeAnimationState createState() => new _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
    new AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? new Opacity(
      opacity: 1.0 - animationController.value,
      child: widget.child,
    )
        : new Container();
  }
}
