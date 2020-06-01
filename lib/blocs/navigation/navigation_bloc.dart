import 'package:hydrated_bloc/hydrated_bloc.dart';

enum RouteEvent { home, fissures, invasions, sortie, syndicates, droptable }

enum RouteState { home, fissures, invasions, sortie, syndicates, droptable }

class NavigationBloc extends HydratedBloc<RouteEvent, RouteState> {
  @override
  RouteState get initialState => super.initialState ?? RouteState.home;

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    yield eventToState(event);
  }

  @override
  Stream<RouteState> transformEvents(Stream<RouteEvent> events,
      Stream<RouteState> Function(RouteEvent event) next) {
    return super.transformEvents(events.distinct(), next);
  }

  RouteState eventToState(RouteEvent event) {
    switch (event) {
      case RouteEvent.home:
        return RouteState.home;
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
        return RouteState.home;
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
