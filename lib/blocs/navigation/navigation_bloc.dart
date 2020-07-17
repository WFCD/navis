import 'package:navis/blocs/bloc.dart';

enum RouteEvent { home, fissures, invasions, sortie, syndicates, droptable }

enum RouteState { home, fissures, invasions, sortie, syndicates, droptable }

class NavigationBloc extends Bloc<RouteEvent, RouteState> {
  NavigationBloc() : super(RouteState.home);

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    yield eventToState(event);
  }

  @override
  Stream<Transition<RouteEvent, RouteState>> transformEvents(
    events,
    transitionFn,
  ) {
    return super.transformEvents(events.distinct(), transitionFn);
  }

  RouteState eventToState(RouteEvent event) {
    switch (event) {
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

  // @override
  // RouteState fromJson(Map<String, dynamic> json) {
  //   final route = RouteState.values
  //       .firstWhere((v) => v.toString().contains(json['last']));

  //   return route;
  // }

  // @override
  // Map<String, dynamic> toJson(RouteState state) {
  //   return {'last': state.toString()};
  // }
}
