import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider.dart';

class Platforms implements Base {
  factory Platforms() {
    final selectedPlatform = BehaviorSubject<String>(); // ignore: close_sinks
    final currentPlatform = selectedPlatform.distinct().doOnData(_onData);

    return Platforms._(selectedPlatform, currentPlatform);
  }

  Platforms._(this.selectedPlatform, this.currentPlatform);

  static String kPlatform = 'pc';

  Sink<String> selectedPlatform;
  Stream<String> currentPlatform;

  static Future<void> _onData(String platform) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Platform', platform);
    kPlatform = platform;
  }

  Future<void> _retrivePlatform() async {
    final prefs = await SharedPreferences.getInstance();

    kPlatform = prefs.getString('Platform') ?? 'pc';
  }

  @override
  void dispose() => selectedPlatform.close();

  @override
  void initState() {
    _retrivePlatform();
  }
}
