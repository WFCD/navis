import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import 'navigation_states.dart';

class NavigationBloc extends Bloc<RouteEvent, RouteState>
    with EquatableMixinBase, EquatableMixin {
  @override
  RouteState get initialState => TimerState();

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    switch (event) {
      case RouteEvent.news:
        yield NewsState();
        break;
      case RouteEvent.timers:
        yield TimerState();
        break;
      case RouteEvent.syndicates:
        yield SyndicatesState();
        break;
    }
  }

  @override
  Stream<RouteState> transform(Stream<RouteEvent> events,
      Stream<RouteState> Function(RouteEvent event) next) {
    //ignore: avoid_as
    return super.transform((events as Observable<RouteEvent>).distinct(), next);
  }
}
