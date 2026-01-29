import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();

  static final _logger = Logger('AppBlocObserver');

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    _logger.info('onEvent(${bloc.runtimeType}, $event)');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    _logger.info('onChange(${bloc.runtimeType}, $change)');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    _logger.info('onTransition(${bloc.runtimeType}), $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    _logger.warning('onClose(${bloc.runtimeType})');
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (error is StateError && error.message.contains('Cannot emit')) {
      _logger.warning('${bloc.runtimeType} was closed before new state was emmited');
    } else {
      _logger.shout('onError(${bloc.runtimeType})', error, stackTrace);
    }

    super.onError(bloc, error, stackTrace);
  }
}
