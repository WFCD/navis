import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum RouteEvent {
  news,
  timers,
  fissures,
  invasions,
  sortie,
  syndicates,
  droptable
}

enum RouteState {
  news,
  timers,
  fissures,
  invasions,
  sortie,
  syndicates,
  droptable
}

class NavigationBloc extends HydratedBloc<RouteEvent, RouteState>
    with EquatableMixinBase, EquatableMixin {
  @override
  RouteState get initialState => super.initialState ?? RouteState.timers;

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    yield eventToState(event);
  }

  @override
  Stream<RouteState> transform(Stream<RouteEvent> events,
      Stream<RouteState> Function(RouteEvent event) next) {
    return super.transform(Observable<RouteEvent>(events).distinct(), next);
  }

  RouteState eventToState(RouteEvent event) {
    switch (event) {
      case RouteEvent.news:
        return RouteState.news;
      case RouteEvent.timers:
        return RouteState.timers;
      case RouteEvent.fissures:
        return RouteState.fissures;
      case RouteEvent.invasions:
        return RouteState.invasions;
      case RouteEvent.sortie:
        return RouteState.sortie;
      case RouteEvent.syndicates:
        return RouteState.syndicates;
      case RouteEvent.droptable:
        return RouteState.droptable;
      default:
        return RouteState.timers;
    }
  }

  @override
  RouteState fromJson(Map<String, dynamic> json) {
    final route = RouteEvent.values
        .firstWhere((v) => v.toString() == 'RouteEvent.${json['last']}');

    return eventToState(route);
  }

  @override
  Map<String, dynamic> toJson(RouteState state) {
    return {'last': state.toString().split('.').last};
  }
}
