import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/features/worldstate/presentation/pages/home_feed.dart';

enum NavigationEvent { timers, codex }

class NavigationBloc extends HydratedBloc<NavigationEvent, Widget> {
  static final Map<NavigationEvent, Widget> navigationMap = {
    NavigationEvent.timers: const HomeFeedPage(),
    NavigationEvent.codex: Container()
  };

  @override
  Widget get initialState => navigationMap[NavigationEvent.timers];

  @override
  Stream<Widget> transformEvents(Stream<NavigationEvent> events,
      Stream<Widget> Function(NavigationEvent) next) {
    return super.transformEvents(events.distinct(), next);
  }

  @override
  Stream<Widget> mapEventToState(
    NavigationEvent event,
  ) async* {
    yield navigationMap[event];
  }

  @override
  Widget fromJson(Map<String, dynamic> json) {
    final event =
        NavigationEvent.values.firstWhere((n) => n.toString() == json['key']);

    return navigationMap[event];
  }

  @override
  Map<String, dynamic> toJson(Widget state) {
    final key = navigationMap.keys.firstWhere((k) => navigationMap[k] == state);

    return <String, dynamic>{'key': key.toString()};
  }
}
