import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider.dart';

class Platforms implements Base {
  static String _default = 'pc';

  Sink<String> selectedPlatform;
  Stream<String> currentPlatform;

  factory Platforms() {
    final selectedPlatform = BehaviorSubject<String>(); // ignore: close_sinks
    final currentPlatform = selectedPlatform.distinct().doOnData(_onData);

    _first(sink: selectedPlatform);
    return Platforms._(selectedPlatform, currentPlatform);
  }

  Platforms._(this.selectedPlatform, this.currentPlatform);

  static _onData(String platform) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Platform', platform);
  }

  static _first({Sink sink}) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('Platform') == null) {
      await prefs.setString('Platform', _default);
      sink.add(_default);
    } else {
      sink.add(prefs.getString('Platform'));
    }
  }

  @override
  void dispose() => selectedPlatform.close();
}
