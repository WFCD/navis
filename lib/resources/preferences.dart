import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final defaultPlatform = 'pc';

class Preferences {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future firstRun() async {
    var prefs = await _prefs;

    if (prefs.getString('Platform') == null) {
      await prefs.setString('Platform', defaultPlatform);
    }
  }

  Future<Null> setPlatform(String platform) async {
    var prefs = await _prefs;
    await prefs.setString('Platform', platform);
    return null;
  }

  Future<String> getPlatform() async {
    final prefs = await _prefs;
    return prefs.getString('Platform');
  }
}
