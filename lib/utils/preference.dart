import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences preferences;

  Future<String> getString(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  int getInt(String key) {
    return preferences.getInt(key);
  }

  Future<bool> setInt(String key, int value) async {
    return preferences.setInt(key, value);
  }
}
