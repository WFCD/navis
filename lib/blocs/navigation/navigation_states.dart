import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/screens/feed/feed.dart';
import 'package:navis/screens/news/news.dart';
import 'package:navis/screens/syndicates/syndicates.dart';
import 'package:simple_animations/simple_animations.dart';

enum RouteEvent { news, timers, syndicates }

class RouteState extends Equatable {
  RouteEvent route;
  Widget widget;
}

class NewsState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.news;

  @override
  Widget get widget => const FadeIn(child: Orbiter());
}

class TimerState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.timers;

  @override
  Widget get widget => const FadeIn(child: Feed());
}

class SyndicatesState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.syndicates;

  @override
  Widget get widget => FadeIn(child: SyndicatesList());
}

class FadeIn extends StatelessWidget {
  const FadeIn({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeIn,
        playback: Playback.PLAY_FORWARD,
        builder: (context, value) => Opacity(opacity: value, child: child));
  }
}
