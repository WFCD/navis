import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/screens/drops/drops_list.dart';
import 'package:navis/screens/feed/feed.dart';
import 'package:navis/screens/fissures/fissures.dart';
import 'package:navis/screens/invasions/invasions.dart';
import 'package:navis/screens/news/news.dart';
import 'package:navis/screens/sortie/sortie.dart';
import 'package:navis/screens/syndicates/syndicates.dart';

enum RouteEvent {
  news,
  timers,
  fissures,
  invasions,
  sortie,
  syndicates,
  droptable
}

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

class FissureState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.fissures;

  @override
  Widget get widget => const FissureList();
}

class InvasionsState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.invasions;

  @override
  Widget get widget => const InvasionsList();
}

class SortieState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.sortie;

  @override
  Widget get widget => const SortieScreen();
}

class SyndicatesState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.syndicates;

  @override
  Widget get widget => SyndicatesList();
}

class DropTableState extends RouteState {
  @override
  RouteEvent get route => RouteEvent.droptable;

  @override
  Widget get widget => const DropTableList();
}
