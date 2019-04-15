import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
}
