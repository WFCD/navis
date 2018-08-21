import 'dart:async';

import 'package:countdown/countdown.dart';

class CounterScreenStream extends Stream<Duration> {
  final Stream<Duration> _stream;

  CounterScreenStream(Duration initialValue)
      : this._stream = createStream(initialValue);

  @override
  StreamSubscription<Duration> listen(
    void onData(Duration event), {
    Function onError,
    void onDone(),
    bool cancelOnError,
  }) =>
      _stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  static Stream<Duration> createStream(Duration initialValue) {
    var countdown = CountDown(initialValue);
    return countdown.stream.asBroadcastStream();
  }
}
