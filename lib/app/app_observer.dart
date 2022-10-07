import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}), ${change.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}), $error, $stackTrace');
    Sentry.captureException(error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
