import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

mixin SafeBlocMixin<S> on BlocBase<S> {
  Logger get logger => Logger(runtimeType.toString());

  Future<void> safeEmit(
    FutureOr<S> Function() callback, {
    S Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      final state = await callback();
      if (!isClosed) emit(state);
    } on Exception catch (error, stackTrace) {
      logger.warning('Error in operation', error, stackTrace);

      addError(error, stackTrace);
      if (onError != null && !isClosed) emit(onError(error, stackTrace));
    }
  }
}
