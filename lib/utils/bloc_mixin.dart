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
      if (isClosed) {
        logger.warning('$runtimeType was closed before new state was emitted');
        return;
      }

      logger.warning('Error in operation', error, stackTrace);

      addError(error, stackTrace);
      if (onError != null) emit(onError(error, stackTrace));
    }
  }
}
