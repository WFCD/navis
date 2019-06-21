import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'navigation_states.dart';

class NavigationBloc extends HydratedBloc<RouteEvent, RouteState>
    with EquatableMixinBase, EquatableMixin {
  @override
  RouteState get initialState => super.initialState ?? TimerState();

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    yield eventToState(event);
  }

  @override
  Stream<RouteState> transform(Stream<RouteEvent> events,
      Stream<RouteState> Function(RouteEvent event) next) {
    //ignore: avoid_as
    return super.transform((events as Observable<RouteEvent>).distinct(), next);
  }

  RouteState eventToState(RouteEvent event) {
    switch (event) {
      case RouteEvent.news:
        return NewsState();
      case RouteEvent.timers:
        return TimerState();
      case RouteEvent.fissures:
        return FissureState();
      case RouteEvent.invasions:
        return InvasionsState();
      case RouteEvent.sortie:
        return SortieState();
      case RouteEvent.syndicates:
        return SyndicatesState();
      default:
        return TimerState();
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
    return {'last': state.route.toString().split('.').last};
  }
}
