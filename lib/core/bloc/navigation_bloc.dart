import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/features/synthtargets/presentation/pages/targets.dart';
import 'package:navis/features/worldstate/presentation/pages/home_feed.dart';
import 'package:rxdart/rxdart.dart';

enum NavigationEvent { timers, synthTargets }

class NavigationBloc extends HydratedBloc<NavigationEvent, Widget> {
  static final Map<NavigationEvent, Widget> navigationMap = {
    NavigationEvent.timers: const HomeFeedPage(),
    NavigationEvent.synthTargets: const SynthTargetsPage()
  };

  @override
  Widget get initialState => navigationMap[NavigationEvent.timers];

  @override
  Stream<Transition<NavigationEvent, Widget>> transformEvents(
    Stream<NavigationEvent> events,
    TransitionFunction<NavigationEvent, Widget> transitionFn,
  ) {
    return events.switchMap(transitionFn);
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
