import 'dart:async';

import 'package:logging/logging.dart';

typedef Debounceable<S, T> = FutureOr<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
Debounceable<S, T> debounce<S, T>(Debounceable<S?, T> function) {
  _Debouncer? debouncer;

  return (T parameter) async {
    if (debouncer != null && !debouncer!.isCompleted) {
      debouncer!.cancel();
    }

    debouncer = _Debouncer(300);

    try {
      await debouncer!.future;
    } on _CancelException {
      return null;
    }

    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _Debouncer {
  _Debouncer(this.milliseconds) {
    _timer = Timer(Duration(milliseconds: milliseconds), _onComplete);
  }

  static final _logger = Logger('_Debouncer');

  late final Timer _timer;
  final int milliseconds;

  final _completer = Completer<void>();

  void _onComplete() {
    _logger.fine('Completing callback');
    return _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _logger.finer('canceling timer');
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}
