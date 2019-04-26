import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/ui/screens/news/news.dart';
import 'package:navis/ui/screens/feed/feed.dart';
import 'package:navis/ui/screens/syndicates/syndicates.dart';

enum RouteEvent { news, timers, syndicates }

class RouteState extends Equatable {
  RouteEvent route;
  Widget widget;
}

class NewsState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.news;

  @override
  Widget get widget => const Orbiter();
}

class TimerState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.timers;

  @override
  Widget get widget => const Feed();
}

class SyndicatesState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.syndicates;

  @override
  Widget get widget => SyndicatesList();
}
