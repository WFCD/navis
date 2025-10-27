import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class ConnectionManager {
  static final _connectionChecker = InternetConnection.createInstance(
    customCheckOptions: [InternetCheckOption(uri: Uri.parse('https://api.warframe.com/cdn/worldState.php'))],
  );

  static Future<bool> get hasInternetConnection => _connectionChecker.hasInternetAccess;

  static Future<T> call<T>(FutureOr<T> Function() todo) async {
    if (await hasInternetConnection) return await todo();
    while (!(await _connectionChecker.hasInternetAccess)) {}

    return await todo();
  }
}
