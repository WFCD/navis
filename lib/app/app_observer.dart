import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const _breadcrumbType = 'bloc';

// Got it from here https://gist.github.com/ueman/e002523741b496270dcabef2683e136e
class AppBlocObserver extends BlocObserver {
  AppBlocObserver({Hub? hub}) : _hub = hub ?? HubAdapter();

  final Hub _hub;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    final message = 'onEvent(${bloc.runtimeType}, $event)';

    _hub.addBreadcrumb(
      Breadcrumb(
        type: _breadcrumbType,
        category: 'onEvent',
        message: message,
        data: {'bloc': bloc.runtimeType},
      ),
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    final message = 'onChange(${bloc.runtimeType}), ${change.runtimeType}';

    _hub.addBreadcrumb(
      Breadcrumb(
        type: _breadcrumbType,
        category: 'onChange',
        message: message,
        data: {'bloc': bloc.runtimeType},
      ),
    );
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _hub.addBreadcrumb(
      Breadcrumb(
        type: _breadcrumbType,
        category: 'onTransition',
        message: transition.toString(),
        data: {'bloc': bloc.runtimeType},
      ),
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);

    _hub.addBreadcrumb(
      Breadcrumb(
        type: _breadcrumbType,
        category: 'onClose',
        data: {'bloc': bloc.runtimeType},
      ),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    final mechanism = Mechanism(
      type: 'BlocObserver.onError',
      handled: false,
    );

    final throwableMechanism = ThrowableMechanism(mechanism, error);

    final event = SentryEvent(
      throwable: throwableMechanism,
      level: SentryLevel.fatal,
    );

    _hub.captureEvent(event, stackTrace: stackTrace);
  }
}
