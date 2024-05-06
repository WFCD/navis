import 'dart:async';

import 'package:connecteo/connecteo.dart';

abstract class ConnectionManager {
  static final _connectionChecker = ConnectionChecker(
    checkConnectionEntriesWeb: [
      ConnectionEntry.fromUrl('https://api.warframestat.us/'),
    ],
  );

  static Future<bool> get hasInternetConnection =>
      _connectionChecker.isConnected;

  static Future<T> onReconnect<T>(FutureOr<T> Function() todo) async {
    await _connectionChecker.untilConnects();

    return await todo();
  }
}
